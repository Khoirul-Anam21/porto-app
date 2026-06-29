// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  css: ['~/assets/css/main.css'],
  ssr: false,
  devtools: { enabled: true },
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
  typescript: {
    typeCheck: false,
  },
  plugins: [],
  modules: [
    '@vueuse/nuxt',
    'nuxt-icon',
    '@pinia/nuxt',
    "@nuxt/image",
    "nuxt-aos",
    'nuxt-easy-lightbox',
    'nuxt-vitalizer',
  ],
  vitalizer: {
    disableStylesheets: 'entry',
    disablePrefetchLinks: true
  },
  aos: {
    disable: false,
    startEvent: 'DOMContentLoaded',
    initClassName: 'aos-init',
    animatedClassName: 'aos-animate',
    useClassNames: false,
    disableMutationObserver: false,
    debounceDelay: 50,
    throttleDelay: 99,
  },
  runtimeConfig: {
    // Private keys that are only available server-side
    dbHost: process.env.DB_HOST,
    dbPort: process.env.DB_PORT,
    dbName: process.env.DB_NAME,
    dbUser: process.env.DB_USER,
    dbPassword: process.env.DB_PASSWORD,
    
    // Public keys that are exposed to the client
    public: {
      experience_icon: 'https://res.cloudinary.com/dj8gvk6wr/image/upload/v1750565223/directus/e152b968-e69a-4ffe-98e9-462259279d9a__7abd30a2f63f675625d6888e2ed9d65992751e3c.avif',
      education_icon: 'https://res.cloudinary.com/dj8gvk6wr/image/upload/v1750564668/directus/eba4f0dd-0e95-48f4-84c2-f5b52812bbbf__7abd30a2f63f675625d6888e2ed9d65992751e3c.avif'
      // If you need any public config, add here
    }
  },
  compatibilityDate: '2024-07-05',
})
