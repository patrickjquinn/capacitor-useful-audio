import { WebPlugin } from '@capacitor/core';

import type { UsefilAudioPlugin } from './definitions';

export class UsefilAudioWeb extends WebPlugin implements UsefilAudioPlugin {
  audio = new Audio();
  async play64(options: { base64: string }): Promise<any> {
    const self = this
    return new Promise(function(resolve, reject) { // return a promise
      self.audio = new Audio();                     // create audio wo/ src
      self.audio.preload = "auto";                      // intend to play through
      self.audio.autoplay = true;                       // autoplay when loaded
      self.audio.onerror = reject;                      // on error, reject
      self.audio.onended = resolve;                     // when done, resolve
  
      self.audio.src = options.base64; // start loading the audio
    });
  }
  async stop(): Promise<any> {
    this.audio.pause();
    this.audio.currentTime = 0;
    this.audio.src = '';
    return {};
  }
}
