export interface UsefilAudioPlugin {
  play64(options: { base64: string }): Promise<any>;
  stop(): Promise<any>;
}
