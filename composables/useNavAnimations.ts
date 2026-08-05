import { gsap } from 'gsap'

export const useNavAnimations = () => {
    const animateNavEntrance = () => {
        if (!import.meta.client) return

        const nav = document.querySelector('header nav')
        if (!nav) return

        gsap.from(nav.children, {
            opacity: 0,
            y: -10,
            duration: 0.4,
            stagger: 0.08,
            ease: 'power2.out',
        })
    }

    const animateProfileEntrance = () => {
        if (!import.meta.client) return

        gsap.from('.profile-card', {
            opacity: 0,
            y: 20,
            duration: 0.6,
            ease: 'power2.out',
        })
    }

    return {
        animateNavEntrance,
        animateProfileEntrance,
    }
}
