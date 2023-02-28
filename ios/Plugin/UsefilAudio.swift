import Foundation
import Capacitor

import MediaPlayer;
import AVFoundation;
import Alamofire;

var base64Call:CAPPluginCall? = nil
var player:AVAudioPlayer = AVAudioPlayer()
//var streamPlayer:AVPlayer? = AVPlayer()
var preloadAsset:AVURLAsset? = nil
var preloadItem: AVPlayerItem? = nil
var preloadUrl: String? = nil
var streamPlayer: AVPlayer?
var url: URL?
var isPreloading = false

extension AVPlayer {
    var isPlaying: Bool {
        return (rate != 0)
    }
}


@objc public class UsefilAudio: NSObject, AVAudioPlayerDelegate, AVAssetResourceLoaderDelegate {
    @objc public func preload(_ call: CAPPluginCall) {
        if (call.getString("url") == nil) {
            call.reject("Please provide a valid url")
        }
        
        let urlString: String? = call.getString("url")

        if (urlString != nil) {
            print("PRELOADING start")
            url = URL(string: urlString!)

            let asset = AVURLAsset(url: url!)
            
            let keys = ["playable"]
            asset.loadValuesAsynchronously(forKeys: keys) {
                    isPreloading = true
                    DispatchQueue.main.async {
                        if (streamPlayer != nil) {
                            streamPlayer?.cancelPendingPrerolls()
                        }
                        print("VOICE preloading donzo")
                        preloadItem = AVPlayerItem(asset: asset)
                        preloadItem?.preferredForwardBufferDuration = 0.5
                        preloadItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new, .initial], context: nil)
                        preloadItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackBufferEmpty), options: [.new, .initial], context: nil)
                        
                    }
            }
//            preloadAsset!.resourceLoader.setDelegate(self, queue: DispatchQueue.main)
        }
        
        call.resolve()


    }
    
    
    @objc public func play64(_ call: CAPPluginCall) {
        if (call.getString("base64") == nil) {
            call.reject("Please provide a valid base64 encoded string")
        }
        
        let base64 = call.getString("base64")!

        do {
            
            guard let data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
                return call.reject("Error creating base64 audio data")
            }
            player = try AVAudioPlayer(data: data)
            base64Call = call
            player.delegate = self as AVAudioPlayerDelegate
            player.prepareToPlay()
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Error making audio session active")
            }
            player.play()
        }
        catch {
            call.reject("error playing file")
        }
    }

    @objc public func play(_ call: CAPPluginCall) {
        if (call.getString("url") == nil) {
            call.reject("Please provide a valid url")
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error making audio session active")
        }

        base64Call = call
        
        let urlString = call.getString("url")!
        
        guard let url = URL(string: urlString) else { return }
        
        print(url.absoluteString)
        
        var playerItem: AVPlayerItem? = nil

        if (preloadItem != nil) {
            print("VOICE preload hit")
            playerItem = (preloadItem?.copy() as! AVPlayerItem)
        } else {
            let asset = AVURLAsset(url: url)
            playerItem = AVPlayerItem(asset: asset)
            playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.new, .initial], context: nil)
            playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackBufferEmpty), options: [.new, .initial], context: nil)
        }
        streamPlayer = AVPlayer(playerItem: playerItem)

        
        streamPlayer?.currentItem?.preferredForwardBufferDuration = 0.5;
        streamPlayer?.automaticallyWaitsToMinimizeStalling = false
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying),
                                                       name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: streamPlayer?.currentItem)
        streamPlayer?.playImmediately(atRate: 1.0)
    }
    
    deinit {
         // Remove observers when the player is deallocated
        streamPlayer?.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        streamPlayer?.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackBufferEmpty))
     }
     
     // Handle observation of playback and buffer status changes
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
         if keyPath == #keyPath(AVPlayerItem.status) {
             if let statusNumber = change?[.newKey] as? NSNumber, let status = AVPlayerItem.Status(rawValue: statusNumber.intValue) {
                 switch status {
                 case .failed:
                     // Handle failed status
                     print("VOICE failed to play")
                     break
                 case .readyToPlay:
                     print("VOICE ready to play")
                     if (streamPlayer?.isPlaying == false) {
                         streamPlayer?.playImmediately(atRate: 1.0)
                     }
                     // Handle ready status
                     break
                 case .unknown:
                     print("VOICE error unknown")
                     // Handle unknown status
                     break
                 @unknown default:
                     break
                 }
             }
         } else if keyPath == #keyPath(AVPlayerItem.isPlaybackBufferEmpty) {
             if let isBufferingNumber = change?[.newKey] as? NSNumber {
                 let isBuffering = isBufferingNumber.boolValue
                 if isBuffering {
                     print("VOICE buffering")
                     // Handle buffering
                 } else {
                     // Handle buffer full
                     print("VOICE buffer full")

                 }
             }
         }
     }
    
    
    @objc func errorPlaying(note: NSNotification) {
        print(note);
        if (base64Call != nil) {
            base64Call?.resolve()
            base64Call = nil
            streamPlayer = nil
        }
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("PRELOADING player done.")
        if (base64Call != nil) {
            preloadUrl = nil
//            if (streamPlayer != nil){
//                isPreloading = false
//                streamPlayer?.cancelPendingPrerolls()
//            }
            streamPlayer?.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
            streamPlayer?.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.isPlaybackBufferEmpty))
            streamPlayer = nil
            preloadAsset = nil
            preloadItem = nil
            base64Call?.resolve()
            base64Call = nil
        }
    }
    
    @objc public func stop(_ call: CAPPluginCall) {
        if (streamPlayer != nil && ((streamPlayer?.isPlaying) != nil)) {
            streamPlayer?.pause();
        } else {
            player.stop()
        }
//        if (base64Call != nil) {
//            base64Call?.resolve()
//            base64Call = nil
//        }
        call.resolve()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (base64Call != nil) {
            base64Call?.resolve()
            base64Call = nil
        }
    }
    
    public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if (base64Call != nil) {
            base64Call?.reject("An error occured in the player")
            base64Call = nil
        }
    }
}
