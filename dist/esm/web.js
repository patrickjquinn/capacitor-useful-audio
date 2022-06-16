import { WebPlugin } from '@capacitor/core';
export class UsefilAudioWeb extends WebPlugin {
    async play64(options) {
        console.log('Not for web', options);
        return options;
    }
    async playLocalAudio(options) {
        console.log('Not for web', options);
        return options;
    }
    async playUrl(options) {
        console.log('ECHO', options);
        return options;
    }
}
//# sourceMappingURL=web.js.map