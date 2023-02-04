import { WebPlugin } from '@capacitor/core';
import type { UsefilAudioPlugin } from './definitions';
export declare class UsefilAudioWeb extends WebPlugin implements UsefilAudioPlugin {
    audio: HTMLAudioElement;
    play64(options: {
        base64: string;
    }): Promise<any>;
    stop(): Promise<any>;
}
