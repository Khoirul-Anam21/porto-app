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
        link: '',
        icon: "ic:baseline-whatsapp",
    },
    {
        id: 1,
        username: 'fulan',
        link: '',
        icon: "tabler:brand-telegram",
    },
    {
        id: 2,
        username: 'fulan',
        link: '',
        icon: "ri:linkedin-box-line",
    },
    {
        id: 3,
        username: 'fulan',
        link: '',
        icon: "mdi:instagram",
    }
])