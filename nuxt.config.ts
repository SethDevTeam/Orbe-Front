// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
	ssr: false, // Disable server-side rendering
	compatibilityDate: "2025-07-15",
	devtools: { enabled: true },
	modules: ["@nuxt/ui", "@pinia/nuxt"],
	css: ["~/assets/css/main.css"],
	nitro: {
		experimental: {
			database: true,
		},
	},
});
