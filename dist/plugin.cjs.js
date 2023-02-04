'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const UsefilAudio = core.registerPlugin('UsefilAudio', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.UsefilAudioWeb()),
});

class UsefilAudioWeb extends core.WebPlugin {
    constructor() {
        super(...arguments);
        this.audio = new Audio();
    }
    async play64(options) {
        const self = this;
        return new Promise(function (resolve, reject) {
            self.audio = new Audio(); // create audio wo/ src
            self.audio.preload = "auto"; // intend to play through
            self.audio.autoplay = true; // autoplay when loaded
            self.audio.onerror = reject; // on error, reject
            self.audio.onended = resolve; // when done, resolve
            self.audio.src = options.base64; // start loading the audio
        });
    }
    async stop() {
        this.audio.pause();
        this.audio.currentTime = 0;
        this.audio.src = '';
        return {};
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    UsefilAudioWeb: UsefilAudioWeb
});

exports.UsefilAudio = UsefilAudio;
//# sourceMappingURL=plugin.cjs.js.map
