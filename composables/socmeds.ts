export interface SocmedInterface {
    id: number;
    username: string;
    link: string;
    icon: string;
}

export const socmedData: Ref<SocmedInterface[]> = ref([
    {
        id: 0,
        username: 'fulan',
        link: 'https://wa.me/087894524561',
        icon: "ic:baseline-whatsapp",
    },
    {
        id: 1,
        username: 'fulan',
        link: 'https://t.me/khairul_nam',
        icon: "tabler:brand-telegram",
    },
    {
        id: 2,
        username: 'fulan',
        link: 'https://www.linkedin.com/in/mohammad-khoirul-anam21/',
        icon: "ri:linkedin-box-line",
    },
    {
        id: 3,
        username: 'fulan',
        link: 'https://instagram.com/mohkhoirul_a?igshid=NGVhN2U2NjQ0Yg==',
        icon: "mdi:instagram",
    },
    {
        id: 3,
        username: 'fulan',
        link: 'mailto:khairulanamstud@gmail.com',
        icon: "material-symbols:mail-outline",
    },
    {
        id: 3,
        username: 'fulan',
        link: 'https://github.com/Khoirul-Anam21',
        icon: "mdi:github",
    }
])