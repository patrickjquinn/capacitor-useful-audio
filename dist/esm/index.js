import { registerPlugin } from '@capacitor/core';
const UsefilAudio = registerPlugin('UsefilAudio', {
    web: () => import('./web').then(m => new m.UsefilAudioWeb()),
});
export * from './definitions';
export { UsefilAudio };
//# sourceMappingURL=index.js.map