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
                                        // Use process.cwd() to get the project root, then append the path
                                        name: `${process.cwd()}/server/db/prototype.sqlite`
                                }
                        }
                }
        }
})
