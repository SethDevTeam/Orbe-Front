import { fileURLToPath } from 'node:url'
import { dirname, join } from 'node:path'

const currentDir = dirname(fileURLToPath(import.meta.url))

export default defineNuxtConfig({
        compatibilityDate: '2024-11-01',
        devtools: { enabled: true },
        modules: ["@nuxt/ui", "@pinia/nuxt"],
        css: ["~/assets/css/main.css"],
        imports: {
                autoImport: true,
        },
        nitro: {
                experimental: {
                        database: true,
                },
                database: {
                        prototype: {
                                connector: 'better-sqlite3',
                                options: {
                                        name: join(currentDir, 'server/db/prototype.sqlite')
                                }
                        },
                        clients: {
                                connector: 'better-sqlite3',
                                options: {
                                        name: join(currentDir, 'server/db/clients.sqlite')
                                }
                        },
                        inventory: {
                                connector: 'better-sqlite3',
                                options: {
                                        name: join(currentDir, 'server/db/inventory.sqlite')
                                }
                        }
                }
        }
})
