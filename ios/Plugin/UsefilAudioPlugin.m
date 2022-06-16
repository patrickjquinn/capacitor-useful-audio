#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(UsefilAudioPlugin, "UsefilAudio",
        CAP_PLUGIN_METHOD(play64, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(playLocalAudio, CAPPluginReturnPromise);
        CAP_PLUGIN_METHOD(playUrl, CAPPluginReturnPromise);
)
