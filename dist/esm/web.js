import { WebPlugin } from '@capacitor/core';
export class UsefilAudioWeb extends WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
}
//# sourceMappingURL=web.js.map