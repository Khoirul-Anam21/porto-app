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
        'loop-scroll-up': {
          from: { transform: 'translatey(0)' },
          to: { transform: 'translatey(-100%)' },
        },
        'loop-scroll-down': {
          from: { transform: 'translatey(-100%)' },
          to: { transform: 'translatey(0)' },
        },
        rotate: {
          '0%': { transform: 'rotate(0deg)' },
          '100%': { transform: 'rotate(180deg)' },
        },
        rotateback: {
          '0%': { transform: 'rotate(180deg)' },
          '100%': { transform: 'rotate(360deg)' },
        },
        horizontalBounce: {
          '0%': {
            transform: 'none',
            'animation-timing-function': 'cubic-bezier(0.8,0,1,1)'
          },
          '50%': {
            transform: 'translateX(-25%)',
            'animation-timing-function': 'cubic-bezier(0,0,0.2,1)',
          }
        }
      },
      animation: {
        rotate: 'rotate 1s linear',
        rotateback: 'rotateback 1s linear',
        horizontalBounce: 'horizontalBounce 1s ease-out infinite',
        'loop-scroll-up': 'loop-scroll-up 20s linear infinite',
        'loop-scroll-down': 'loop-scroll-down 20s linear infinite',
      },
      colors: {
        'primary-dark': '#2C2D32',
        'primary-light': '#FFFFFF',
        'turquoise': '#30D5C8',
        'light-turquoise': '#D4FFFC',
        'dark-turquoise': '#06768D',
        'accent-color': '#F0BF6C'
      },
      fontFamily: {
        sans: 'Helvetica, Arial, sans-serif'
      },
    },
  },
  plugins: [require('@tailwindcss/typography')],
}

