package app.getradiant.usefulaudio;

import android.media.MediaDataSource;
import android.media.MediaPlayer;
import android.util.Base64;

import com.getcapacitor.PluginCall;

import java.io.IOException;

public class UsefilAudio {

    private MediaPlayer mediaPlayer;

    public void play64(PluginCall call) {
        String base64 = call.getString("base64");
        try{
            String url = base64;
            // if (mediaPlayer != null){
            //     mediaPlayer.reset();
            // }
            // if (mediaPlayer != null && mediaPlayer.isPlaying()) {
            //     mediaPlayer.stop();
            //     mediaPlayer.release();
            // }

            if (mediaPlayer == null) {
                mediaPlayer = new MediaPlayer();
            }

            mediaPlayer = new MediaPlayer();

            try {
                byte[] data = Base64.decode(url, Base64.DEFAULT);

                // mediaPlayer.setDataSource(url);
                mediaPlayer.setDataSource(new MediaDataSource() {
                    @Override
                    public long getSize() {
                        return data.length;
                    }
                
                    @Override
                    public int readAt(long position, byte[] buffer, int offset, int size) {
                        int length = (int)getSize();
                        if (position >= length) return -1;
                        if (position + size > length) size = length - (int)position;
                
                        System.arraycopy(data, (int) position, buffer, offset, size);
                        return size;
                    }
                
                    @Override
                    public synchronized void close() throws IOException {
                        // nothing to do
                    }
                });
                mediaPlayer.prepareAsync();
                mediaPlayer.setVolume(100f, 100f);
                mediaPlayer.setLooping(false);
            } catch (IllegalArgumentException e) {
                call.reject("IllegalArgumentException");
            } catch (SecurityException e) {
                call.reject("SecurityException");
            } catch (IllegalStateException e) {
                call.reject("IllegalStateException");
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
