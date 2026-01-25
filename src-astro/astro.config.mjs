// @ts-check
import { defineConfig } from 'astro/config';
const host = 'localhost' //process.env.TAURI_DEV_HOST;
// https://astro.build/config
console.log(`ASStRO confIG ${host}`)
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
                    port: 1421,
                }
                : undefined,
        }
    },
        // 2. tauri expects a fixed port, fail if that port is not available
        server: {
            port: 1420,
            // strictPort: true,
            host: host || false,
        }
});
