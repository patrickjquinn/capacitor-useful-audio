package app.getradiant.usefulaudio;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "UsefilAudio")
public class UsefilAudioPlugin extends Plugin {

    private UsefilAudio implementation = new UsefilAudio();

    @PluginMethod
    public void play64(PluginCall call) {
        implementation.play64(call);
    }

    @PluginMethod
    public void stop(PluginCall call) {
        implementation.stop(call);
       
    }
}
