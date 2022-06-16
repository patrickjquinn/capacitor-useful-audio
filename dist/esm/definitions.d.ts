export interface UsefilAudioPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
