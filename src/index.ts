import { registerPlugin } from '@capacitor/core';

import type { UsefilAudioPlugin } from './definitions';

const UsefilAudio = registerPlugin<UsefilAudioPlugin>('UsefilAudio', {
  web: () => import('./web').then(m => new m.UsefilAudioWeb()),
});

export * from './definitions';
export { UsefilAudio };
