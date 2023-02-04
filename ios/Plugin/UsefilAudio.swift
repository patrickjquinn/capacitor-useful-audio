import Foundation
import Capacitor

import MediaPlayer;
import AVFoundation;

var base64Call:CAPPluginCall? = nil
var player:AVAudioPlayer = AVAudioPlayer()


@objc public class UsefilAudio: NSObject, AVAudioPlayerDelegate {
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
    
    @objc public func stop(_ call: CAPPluginCall) {
        player.stop()
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
