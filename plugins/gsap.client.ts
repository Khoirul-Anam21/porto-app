import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

export default defineNuxtPlugin(() => {
    if (import.meta.client) {
        gsap.registerPlugin(ScrollTrigger)

        gsap.config({
            nullTargetWarn: false,
        })

        ScrollTrigger.defaults({
            toggleActions: 'play none none none',
        })
    }

    return {
        provide: {
            gsap,
            ScrollTrigger,
        },
    }
})
