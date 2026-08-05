/** @type {import('tailwindcss').Config} */
module.exports = {
  // darkMode: false, // before was 'class'
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
        'loop-scroll-up': 'loop-scroll-up 60s linear infinite',
        'loop-scroll-down': 'loop-scroll-down 60s linear infinite',
      },
      colors: {
        // Paper tones
        'paper': '#F8F4EC',
        'paper-dark': '#EDE8DE',
        'paper-shadow': '#E8E0D0',
        'paper-edge': '#D4C9B8',
        
        // Nature accents
        'leaf': '#6B8F3C',
        'leaf-dark': '#4A6B28',
        'leaf-light': '#A8C97A',
        'bark': '#5C4033',
        'bark-light': '#8B7355',
        'sky': '#87CEEB',
        'sky-light': '#B8E2F8',
        'sunlight': '#F4D03F',
        'sunlight-light': '#F9E79F',
        
        // Keep existing for backward compat
        'primary-dark': '#2C2D32',
        'primary-light': '#FFFFFF',
        'turquoise': '#30D5C8',
        'light-turquoise': '#D4FFFC',
        'dark-turquoise': '#06768D',
        'accent-color': '#F0BF6C'
      },
      boxShadow: {
        'paper': '0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.08)',
        'paper-md': '0 4px 6px rgba(0,0,0,0.1), 0 2px 4px rgba(0,0,0,0.06)',
        'paper-lg': '0 10px 15px rgba(0,0,0,0.1), 0 4px 6px rgba(0,0,0,0.05)',
        'paper-hover': '0 14px 28px rgba(0,0,0,0.12), 0 10px 10px rgba(0,0,0,0.08)',
        'paper-raised': 'inset 1px 1px 0 rgba(255,255,255,0.8), inset -1px -1px 0 rgba(0,0,0,0.06), 3px 3px 10px rgba(0,0,0,0.15), -1px -1px 0 rgba(255,255,255,0.5)',
      },
      fontFamily: {
        sans: 'Helvetica, Arial, sans-serif'
      },
    },
  },
  plugins: [require('@tailwindcss/typography')],
}

