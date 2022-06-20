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
    
    @objc func stop(_ call: CAPPluginCall) {
        implementation.stop(call)
    }
}
