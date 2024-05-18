<script setup lang="ts">
// import { useColorMode } from '@vueuse/core'
import { socmedData } from '@/composables/socmeds';
import { useStateStore } from '@/stores/index';

const colorMode = useColorMode();
const stateStore = useStateStore();
const toggleDarkTheme = () => {
    if (colorMode.value === 'light') {
        colorMode.value = 'dark';
        return;
    }
    colorMode.value = 'light';
};

const goTo = (reference: string) => {
    const element = document.getElementById(reference);
    if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
    }
}

const isDark = computed(() => colorMode.value === 'dark');

const openSocmedPage = (url: string) => {
    window.open(url, '_blank');
}

const { x, y } = useWindowScroll();

const isScrolledEnough = computed(() => y.value > 200);

watch(stateStore.$state, (newV, oldV) => {
    console.log(newV);
    if (!newV.socmedActive) {
        return
    }
    setTimeout(() => {
        if (stateStore.$state.socmedIndex === 5) {
            stateStore.$state.socmedIndex = 0
            return;
        }
        stateStore.$state.socmedIndex++
    }, 1000);
});

</script>

<template>
    <div>
        <header class="w-full p-8 fixed top-0  z-50" :class="{ 'bg-white dark:bg-primary-dark': isScrolledEnough }">
            <!-- <nav class="sm:flex">
                <div class="flex justify-between items-center w-full">
                    <div @click="goTo('main')" class="primary-text cursor-pointer text-2xl">
                        Khoirul <span class="highlight-text">Anam</span>
                    </div>
                    <div class="sm:hidden">
                        <button type="button"
                            class="hs-collapse-toggle p-2 inline-flex justify-center items-center gap-x-2 rounded-lg border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-transparent dark:border-gray-700 dark:text-white dark:hover:bg-white/10 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                            data-hs-collapse="#navbar-collapse-with-animation"
                            aria-controls="navbar-collapse-with-animation" aria-label="Toggle navigation">
                            <svg class="hs-collapse-open:hidden flex-shrink-0 size-4" xmlns="http://www.w3.org/2000/svg"
                                width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="3" x2="21" y1="6" y2="6" />
                                <line x1="3" x2="21" y1="12" y2="12" />
                                <line x1="3" x2="21" y1="18" y2="18" />
                            </svg>
                            <svg class="hs-collapse-open:block hidden flex-shrink-0 size-4"
                                xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <path d="M18 6 6 18" />
                                <path d="m6 6 12 12" />
                            </svg>
                        </button>
                    </div>
                </div>

                <div id="navbar-collapse-with-animation"
                    class="hs-collapse hidden overflow-hidden transition-all duration-300 basis-full grow sm:block">
                    <div class="flex flex-col gap-5 mt-5 sm:flex-row sm:items-center sm:justify-end sm:mt-0 sm:ps-5" :class="{ 'text-primary-dark': isScrolledEnough && !isDark, 'text-white': !isScrolledEnough }">
                        <NuxtLink smooth class="font-medium dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                            href="#about" aria-current="page">About Me</NuxtLink>
                        <NuxtLink smooth class="font-medium dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                            href="#skill">Skills</NuxtLink>
                        <NuxtLink smooth class="font-medium dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                            href="#project">Projects</NuxtLink>
                        <NuxtLink smooth class="font-medium dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                            href="#experience">Experiences</NuxtLink>
                    </div>
                </div>
            </nav> -->
        </header>
        <div class="fixed w-full z-20 top-1/3 right-0 bg-slate-400">
            <div @click="toggleDarkTheme"
                class="absolute top-1/2 left-0 w-24 h-24 rounded-full -translate-x-1/2 flex items-center justify-center side-btn shadow-lg cursor-pointer">
                <div class="flex justify-between w-full p-3"
                    :class="{ 'animate-rotate fill-mode-forward': isDark, 'animate-rotateback fill-mode-forward': !isDark }">
                    <Icon name="material-symbols:dark-mode-outline"
                        :class="{ 'rotate-180': !isDark, '-rotate-180': isDark }" size="28" />
                    <Icon name="material-symbols:light-mode-outline" size="28" />
                </div>
            </div>
            <!-- <div class="absolute top-1/3 right-0 inline-flex flex-col space-y-1">
                <button v-for="(item, index) in socmedData" :key="index" class="side-btn p-2"
                    @click="openSocmedPage(item.link)"
                    :class="{ 'animate-horizontalBounce': stateStore.$state.socmedIndex === index && stateStore.$state.socmedActive }">
                    <Icon :name="item.icon" size="24" />
                </button>
            </div> -->
        </div>
        <slot></slot>
    </div>
</template>

<style scoped>
.fill-mode-forward {
    animation-fill-mode: forwards;
}
</style>