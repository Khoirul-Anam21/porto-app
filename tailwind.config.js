/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
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
      keyframes: {
        rotate: {
          '0%': { transform: 'rotate(0deg)' },
          '100%': { transform: 'rotate(180deg)' },
        },
        rotateback: {
          '0%': { transform: 'rotate(180deg)' },
          '100%': { transform: 'rotate(360deg)' },
        }
      },
      animation: {
        rotate: 'rotate 1s linear',
        rotateback: 'rotateback 1s linear',
      },
      colors: {
        'primary-dark': '#2C2D32',
        'primary-light': '#FFFFFF',
        'turquoise': '#30D5C8',
        'light-turquoise': '#D4FFFC',
        'dark-turquoise': '#06768D'
      },
      fontFamily: {
        sans: 'Helvetica, Arial, sans-serif'
      },
    },
  },
  plugins: [],
}

