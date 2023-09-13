export interface SkillInterface {
    id: number;
    name: string;
    icon: string;
}

export const skillData: Ref<SkillInterface[]> = ref([
    {
        id: 1,
        name: 'Express',
        icon: "skill-icons:expressjs-dark",
    },
    {
        id: 2,
        name: 'MongoDB',
        icon: "skill-icons:mongodb",
    },
    {
        id: 3,
        name: 'Vue.js',
        icon: "logos:vue",
    },
    {
        id: 3,
        name: 'Nuxt',
        icon: "logos:nuxt-icon",
    },
    {
        id: 3,
        name: 'Tailwind',
        icon: "logos:tailwindcss-icon",
    },
    {
        id: 3,
        name: 'JavaScript',
        icon: "logos:javascript",
    },
    {
        id: 3,
        name: 'TypeScript',
        icon: "logos:typescript-icon",
    },
    {
        id: 3,
        name: 'Flutter',
        icon: "devicon:flutter",
    },
])