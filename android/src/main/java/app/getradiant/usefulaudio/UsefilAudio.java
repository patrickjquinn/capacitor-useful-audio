package app.getradiant.usefulaudio;

import com.getcapacitor.PluginCall;
import android.media.MediaPlayer;
import android.util.Log;

import java.io.IOException;

public class UsefilAudio {

    private MediaPlayer mediaPlayer;

    public void play64(PluginCall call) {
        String base64 = call.getString("base64");
        try{
            String url = base64;
            if (mediaPlayer != null){
                mediaPlayer.reset();
            }
            mediaPlayer = new MediaPlayer();

            try {
                mediaPlayer.setDataSource(url);
                mediaPlayer.prepareAsync();
                mediaPlayer.setVolume(100f, 100f);
                mediaPlayer.setLooping(false);
            } catch (IllegalArgumentException e) {
                call.reject("IllegalArgumentException");
            } catch (SecurityException e) {
                call.reject("SecurityException");
            } catch (IllegalStateException e) {
                call.reject("IllegalStateException");
            } catch (IOException e) {
                Log.e("Error", e.getMessage());
                call.reject("IOException");
            }

            mediaPlayer.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                @Override
                public void onPrepared(MediaPlayer player) {
                    player.start();
                }
            });

            mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
                @Override
                public void onCompletion(MediaPlayer mp) {
                    mp.stop();
                    mp.release();
                    call.resolve();
                }
            });
        }
        catch(Exception e){
            e.printStackTrace();
            call.reject("Exception");
        }
    }

    public void stop(PluginCall call) {
        if (mediaPlayer != null && mediaPlayer.isPlaying()) {
            mediaPlayer.stop();
            mediaPlayer.release();
        }
        call.resolve();
    }
}
