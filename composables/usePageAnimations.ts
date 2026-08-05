import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

const refreshTriggers = () => {
    nextTick(() => {
        setTimeout(() => ScrollTrigger.refresh(), 200)
    })
}

export const usePageAnimations = () => {
    const initHomeAnimations = () => {
        if (!import.meta.client) return

        gsap.from('.hero-title', {
            opacity: 0, y: 30, duration: 0.8, ease: 'power2.out',
        })

        gsap.from('.hero-description', {
            opacity: 0, y: 20, duration: 0.6, delay: 0.2, ease: 'power2.out',
        })
    }

    const initHomeContentAnimations = () => {
        if (!import.meta.client) return

        nextTick(() => {
            const cards = document.querySelectorAll('.specialty-card')
            cards.forEach((card, i) => {
                gsap.from(card, {
                    scrollTrigger: { trigger: card, start: 'top 85%' },
                    y: 40, opacity: 0, duration: 0.6, delay: i * 0.1, ease: 'power2.out',
                })
            })

            const items = document.querySelectorAll('.language-item')
            items.forEach((item) => {
                gsap.from(item, {
                    scrollTrigger: { trigger: item, start: 'top 90%' },
                    x: -20, opacity: 0, duration: 0.5, ease: 'power2.out',
                })
            })

            refreshTriggers()
        })
    }

    const initProjectsAnimations = () => {
        if (!import.meta.client) return

        gsap.from('.projects-title', { opacity: 0, y: 30, duration: 0.8, ease: 'power2.out' })
        gsap.from('.projects-subtitle', { opacity: 0, y: 20, duration: 0.6, delay: 0.2, ease: 'power2.out' })
        gsap.from('.projects-filters', { opacity: 0, y: 15, duration: 0.5, delay: 0.3, ease: 'power2.out' })
    }

    const initProjectsContentAnimations = () => {
        if (!import.meta.client) return

        nextTick(() => {
            const items = document.querySelectorAll('.project-accordion-item')
            items.forEach((item, i) => {
                gsap.from(item, {
                    scrollTrigger: { trigger: item, start: 'top 85%' },
                    y: 30, opacity: 0, duration: 0.5, delay: i * 0.1, ease: 'power2.out',
                })
            })

            refreshTriggers()
        })
    }

    const initExperiencesAnimations = () => {
        if (!import.meta.client) return

        gsap.from('.experiences-title', { opacity: 0, y: 30, duration: 0.8, ease: 'power2.out' })
        gsap.from('.experiences-subtitle', { opacity: 0, y: 20, duration: 0.6, delay: 0.2, ease: 'power2.out' })
    }

    const initExperiencesContentAnimations = () => {
        if (!import.meta.client) return

        nextTick(() => {
            const items = document.querySelectorAll('.timeline-item')
            items.forEach((item, i) => {
                gsap.from(item, {
                    scrollTrigger: { trigger: item, start: 'top 85%' },
                    y: 30, opacity: 0, duration: 0.5, delay: i * 0.15, ease: 'power2.out',
                })
            })

            refreshTriggers()
        })
    }

    const initEducationsAnimations = () => {
        if (!import.meta.client) return

        gsap.from('.educations-title', { opacity: 0, y: 30, duration: 0.8, ease: 'power2.out' })
        gsap.from('.educations-subtitle', { opacity: 0, y: 20, duration: 0.6, delay: 0.2, ease: 'power2.out' })
    }

    const initEducationsContentAnimations = () => {
        if (!import.meta.client) return

        nextTick(() => {
            const items = document.querySelectorAll('.education-timeline-item')
            items.forEach((item, i) => {
                gsap.from(item, {
                    scrollTrigger: { trigger: item, start: 'top 85%' },
                    y: 30, opacity: 0, duration: 0.5, delay: i * 0.15, ease: 'power2.out',
                })
            })

            refreshTriggers()
        })
    }

    return {
        initHomeAnimations,
        initHomeContentAnimations,
        initProjectsAnimations,
        initProjectsContentAnimations,
        initExperiencesAnimations,
        initExperiencesContentAnimations,
        initEducationsAnimations,
        initEducationsContentAnimations,
    }
}
