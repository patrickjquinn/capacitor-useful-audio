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
        String value = call.getString("play64");

        JSObject ret = new JSObject();
        ret.put("value", implementation.play64(value));
        call.resolve(ret);
    }

    @PluginMethod
    public void playLocalAudio(PluginCall call) {
        String value = call.getString("path");

        JSObject ret = new JSObject();
        ret.put("value", implementation.playLocalAudio(value));
        call.resolve(ret);
    }

    @PluginMethod
    public void playUrl(PluginCall call) {
        String value = call.getString("url");

        JSObject ret = new JSObject();
        ret.put("value", implementation.playUrl(value));
        call.resolve(ret);
    }
}
