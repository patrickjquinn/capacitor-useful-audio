var capacitorUsefilAudio = (function (exports, core) {
    'use strict';

    const UsefilAudio = core.registerPlugin('UsefilAudio', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.UsefilAudioWeb()),
    });

    class UsefilAudioWeb extends core.WebPlugin {
        async echo(options) {
            console.log('ECHO', options);
            return options;
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        UsefilAudioWeb: UsefilAudioWeb
    });

    exports.UsefilAudio = UsefilAudio;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
