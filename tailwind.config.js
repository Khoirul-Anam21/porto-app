/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./components/**/*.{js,vue,ts}",
    "./layouts/**/*.vue",
    "./pages/**/*.vue",
    "./plugins/**/*.{js,ts}",
    "./nuxt.config.{js,ts}",
    "./app.vue",
  ],
  theme: {
    extend: {
      colors: {
        'primary-dark': '#2C2D32',
        'primary-light': '#FFFFFF',
        'turquoise': '#30D5C8',
        'light-turquoise': '#D4FFFC',
        'dark-turquoise': '#06768D'
      },
      fontFamily: {
        sans: 'Helvetica, Arial, sans-serif'
      }
    },
  },
  plugins: [],
}

