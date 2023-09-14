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
        <header class="bg-white dark:bg-primary-dark w-full p-8 fixed top-0 shadow-lg dark:shadow-none z-50">
            <nav class="flex justify-between items-center">
                <div @click="goTo('main')" class="primary-text cursor-pointer text-2xl">
                    Khoirul <span class="highlight-text">Anam</span>
                </div>
                <div>
                    <ul class="flex space-x-9 secondary-text text-sm">
                        <li @click="goTo('about')" class="cursor-pointer">About Me</li>
                        <li @click="goTo('skill')" class="cursor-pointer">Skills</li>
                        <li @click="goTo('project')" class="cursor-pointer">Projects</li>
                        <li @click="goTo('experience')" class="cursor-pointer">Experiences</li>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="fixed w-full z-10 top-1/3 right-0 flex items-center justify-between">
            <div @click="toggleDarkTheme"
                class="w-24 h-24 rounded-full -translate-x-1/2 flex items-center justify-center side-btn shadow-lg cursor-pointer">
                <div class="flex justify-between w-full p-3"
                    :class="{ 'animate-rotate fill-mode-forward': isDark, 'animate-rotateback fill-mode-forward': !isDark }">
                    <Icon name="material-symbols:dark-mode-outline"
                        :class="{ 'rotate-180': !isDark, '-rotate-180': isDark }" size="28" />
                    <Icon name="material-symbols:light-mode-outline" size="28" />
                </div>
            </div>
            <div class="flex flex-col space-y-1">
                <button v-for="(item, index) in socmedData" :key="index" class="side-btn p-2" @click="openSocmedPage(item.link)"
                    :class="{ 'animate-horizontalBounce': stateStore.$state.socmedIndex === index && stateStore.$state.socmedActive }">
                    <Icon :name="item.icon" size="24" />
                </button>
            </div>
        </div>
        <slot></slot>
    </div>
</template>

<style scoped>
.fill-mode-forward {
    animation-fill-mode: forwards;
}
</style>