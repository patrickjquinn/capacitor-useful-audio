export interface UsefilAudioPlugin {
  play64(options: { base64: string }): Promise<any>;
  playLocalAudio(options: { path: string }): Promise<any>;
  playUrl(options: { url: string }): Promise<any>;
}
