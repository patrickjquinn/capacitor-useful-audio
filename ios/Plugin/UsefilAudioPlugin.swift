import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(UsefilAudioPlugin)
public class UsefilAudioPlugin: CAPPlugin {
    private let implementation = UsefilAudio()

    @objc func play64(_ call: CAPPluginCall) {
        implementation.play64(call)
    }
    
    @objc func playLocalAudio(_ call: CAPPluginCall) {
        implementation.playLocalAudio(call)
    }
    
    @objc func playUrl(_ call: CAPPluginCall) {
        implementation.playUrl(call)
    }
}
