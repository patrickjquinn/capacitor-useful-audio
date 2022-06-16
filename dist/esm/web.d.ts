import { WebPlugin } from '@capacitor/core';
import type { UsefilAudioPlugin } from './definitions';
export declare class UsefilAudioWeb extends WebPlugin implements UsefilAudioPlugin {
    play64(options: {
        base64: string;
    }): Promise<any>;
    playLocalAudio(options: {
        path: string;
    }): Promise<any>;
    playUrl(options: {
        url: string;
    }): Promise<any>;
}
