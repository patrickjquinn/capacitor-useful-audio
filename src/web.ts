import { WebPlugin } from '@capacitor/core';

import type { UsefilAudioPlugin } from './definitions';

export class UsefilAudioWeb extends WebPlugin implements UsefilAudioPlugin {
  async play64(options: { base64: string }): Promise<any> {
    console.log('Not for web', options);
    return options;
  }
  async stop(): Promise<any> {
    console.log('Not for web');
  }
}
