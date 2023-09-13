import { defineStore } from 'pinia'

export const useStateStore = defineStore('state', {
    state: () => ({
        // state: null as stateInterface | null,
        socmedActive: false
    }),
    actions: {
        activateSocmed() {
            this.$state.socmedActive = true;
            setTimeout(() => {
                this.$state.socmedActive = false;
            }, 1000)
        },
    }
})