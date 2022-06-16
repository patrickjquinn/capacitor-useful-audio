import Foundation
import Capacitor

import MediaPlayer;


@objc public class UsefilAudio: NSObject {
    @objc public func play64(_ call: CAPPluginCall) {
        let base64 = call.getString("base64")
        let data = Data(base64!.utf8)

        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            call.resolve()
        }

        do {
            let player: AVAudioPlayer = try AVAudioPlayer(data: data)
            // player.delegate = self as! AVAudioPlayerDelegate
            NotificationCenter.default.addObserver(self, selector: Selector(("playerDidFinishPlaying:")), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player)
            player.prepareToPlay()
            player.play()
        }
        catch {
            call.reject("error playing file")
        }
    }
    @objc public func playLocalAudio(_ call: CAPPluginCall) {
        let path = call.getString("path")
        print(path!)
    }
    @objc public func playUrl(_ call: CAPPluginCall) {
        let url = call.getString("url")
        print(url!)

    }
}
