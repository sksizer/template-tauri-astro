// @ts-check
import { defineConfig } from 'astro/config';
const host = 'localhost' //process.env.TAURI_DEV_HOST;
/* eslint-disable-next-line no-undef */
const port = parseInt(process.env.TAURI_DEV_PORT || '1420');
// https://astro.build/config
export default defineConfig({
    // Vite options tailored for Tauri development and only applied in `tauri dev` or `tauri build`
    //
    // 1. prevent Vite from obscuring rust errors
    vite: {
        clearScreen: false,
        server: {
            strictPort: true,
            host: host || false,
            hmr: host
                ? {
                    protocol: "ws",
                    host,
                    port: port + 1,
                }
                : undefined,
        }
    },
        // 2. tauri expects a fixed port, fail if that port is not available
        server: {
            port: port,
            // strictPort: true,
            host: host || false,
        }
});
