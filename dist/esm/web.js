import { WebPlugin } from '@capacitor/core';
export class UsefilAudioWeb extends WebPlugin {
    async play64(options) {
        console.log('Not for web', options);
        return options;
    }
    async stop() {
        console.log('Not for web');
    }
}
//# sourceMappingURL=web.js.map