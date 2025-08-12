import { defineStore } from 'pinia'

export const useStateStore = defineStore('state', {
    state: () => ({
        // state: null as stateInterface | null,
        socmedActive: false,
        socmedIndex: 0,
        timer: null as NodeJS.Timeout | null,
        birthDate: new Date('2001-02-21'),
        currentDate: new Date(),
        address: 'Malang, East Java, Indonesia',
        hobby: 'Reading Comics & Photography',
        name: 'Mohammad Khoirul Anam',
        jobPosition: 'Digital Effectiveness & Web Developer',
        whatsapp_url: 'https://wa.me/6287894524561',
        email_url: 'mailto:khairulanamstud@gmail.com',
        github_url: 'https://github.com/Khoirul-Anam21',
        instagram_url: 'https://www.instagram.com/mohkhoirul_a?igsh=YTFhZXBzMHNiczh2',
        linkedin_url: 'https://www.linkedin.com/in/mohammad-khoirul-anam21/',

    }),
    actions: {
        activateSocmed() {
            this.$state.socmedActive = !this.$state.socmedActive;
        },
        wiggleButtons(){
            this.timer = setTimeout(() => {
                this.$state.socmedIndex++;
            }, 1000);
        },
        stopWiggle() {
            clearTimeout(this.timer as NodeJS.Timeout);
            this.$state.socmedActive = false;
            this.$state.socmedIndex = 0;
        }
    }
})