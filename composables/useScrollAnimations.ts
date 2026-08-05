import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

export const useScrollAnimations = () => {
    const animateCards = (selector: string = '.paper-card') => {
        if (!import.meta.client) return

        gsap.utils.toArray(selector).forEach((card: any) => {
            gsap.from(card, {
                scrollTrigger: {
                    trigger: card,
                    start: 'top 85%',
                    toggleActions: 'play none none none',
                },
                y: 30,
                opacity: 0,
                duration: 0.6,
                ease: 'power2.out',
            })
        })
    }

    const animateFadeUp = (selector: string, delay: number = 0) => {
        if (!import.meta.client) return

        gsap.utils.toArray(selector).forEach((el: any) => {
            gsap.from(el, {
                scrollTrigger: {
                    trigger: el,
                    start: 'top 85%',
                    toggleActions: 'play none none none',
                },
                y: 20,
                opacity: 0,
                duration: 0.6,
                delay,
                ease: 'power2.out',
            })
        })
    }

    const animateFadeIn = (selector: string, delay: number = 0) => {
        if (!import.meta.client) return

        gsap.utils.toArray(selector).forEach((el: any) => {
            gsap.from(el, {
                scrollTrigger: {
                    trigger: el,
                    start: 'top 90%',
                    toggleActions: 'play none none none',
                },
                opacity: 0,
                duration: 0.5,
                delay,
                ease: 'power2.out',
            })
        })
    }

    const animateStagger = (selector: string, staggerAmount: number = 0.1) => {
        if (!import.meta.client) return

        gsap.utils.toArray(selector).forEach((el: any) => {
            gsap.from(el, {
                scrollTrigger: {
                    trigger: el,
                    start: 'top 85%',
                    toggleActions: 'play none none none',
                },
                y: 25,
                opacity: 0,
                duration: 0.5,
                stagger: staggerAmount,
                ease: 'power2.out',
            })
        })
    }

    const animateTimeline = (selector: string) => {
        if (!import.meta.client) return

        gsap.utils.toArray(selector).forEach((item: any) => {
            gsap.from(item, {
                scrollTrigger: {
                    trigger: item,
                    start: 'top 85%',
                    toggleActions: 'play none none none',
                },
                x: -30,
                opacity: 0,
                duration: 0.7,
                ease: 'power2.out',
            })
        })
    }

    const animatePageLoad = (selector: string = '.page-content') => {
        if (!import.meta.client) return

        gsap.from(selector, {
            opacity: 0,
            y: 20,
            duration: 0.5,
            ease: 'power2.out',
        })
    }

    return {
        animateCards,
        animateFadeUp,
        animateFadeIn,
        animateStagger,
        animateTimeline,
        animatePageLoad,
    }
}
