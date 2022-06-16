import { WebPlugin } from '@capacitor/core';
import type { UsefilAudioPlugin } from './definitions';
export declare class UsefilAudioWeb extends WebPlugin implements UsefilAudioPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
