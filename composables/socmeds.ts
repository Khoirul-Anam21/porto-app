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
        icon: "['fab', 'whatsapp']",
    },
    {
        id: 1,
        username: 'fulan',
        link: '',
        icon: "['fab', 'telegram']",
    },
    {
        id: 2,
        username: 'fulan',
        link: '',
        icon: "['fab', 'linkedin']",
    },
    {
        id: 3,
        username: 'fulan',
        link: '',
        icon: "['fab', 'instagram']",
    }
])