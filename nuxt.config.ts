// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  css: ['~/assets/css/main.css'],
  ssr: false,
  routeRules: {
    '/assets/**': {
      proxy: { to: "https:admin.anam6.my.id/assets/**", },
    }
  },
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
  modules: ['@vueuse/nuxt', 'nuxt-icon', '@pinia/nuxt', "@nuxt/image", "nuxt-directus", "nuxt-aos"],
  directus: {
    url: process.env.API_BASE || "http://localhost:8055"
  },
  aos: {
    disable: false, // accepts following values: 'phone', 'tablet', 'mobile', boolean, expression or function
    startEvent: 'DOMContentLoaded', // name of the event dispatched on the document, that AOS should initialize on
    initClassName: 'aos-init', // class applied after initialization
    animatedClassName: 'aos-animate', // class applied on animation
    useClassNames: false, // if true, will add content of `data-aos` as classes on scroll
    disableMutationObserver: false, // disables automatic mutations' detections (advanced)
    debounceDelay: 50, // the delay on debounce used while resizing window (advanced)
    throttleDelay: 99, // the delay on throttle used while scrolling the page (advanced)
  },
  runtimeConfig: {
    public: {
      apiBase: process.env.API_BASE || 'http://localhost:8055',
    }
  },
  compatibilityDate: '2024-07-05',
})