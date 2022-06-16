'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const UsefilAudio = core.registerPlugin('UsefilAudio', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.UsefilAudioWeb()),
});

class UsefilAudioWeb extends core.WebPlugin {
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

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    UsefilAudioWeb: UsefilAudioWeb
});

exports.UsefilAudio = UsefilAudio;
//# sourceMappingURL=plugin.cjs.js.map
