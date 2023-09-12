<script setup lang="ts">
// import { useColorMode } from '@vueuse/core'
import { socmedData } from '@/composables/socmeds';

const colorMode = useColorMode()
const toggleDarkTheme = () => {
    if (colorMode.value === 'light') {
        colorMode.value = 'dark';
        return;
    }
    colorMode.value = 'light';
}

const isDark = computed(() => colorMode.value === 'dark')
</script>

<template>
    <div>
        <header class="bg-white dark:bg-primary-dark w-full p-8 fixed top-0 shadow-lg dark:shadow-none z-50">
            <nav class="flex justify-between items-center">
                <div class="primary-text text-2xl">
                    Lorem <span class="highlight-text">{{ isDark }}</span>
                </div>
                <div>
                    <ul class="flex space-x-9 secondary-text text-sm">
                        <li>About Me</li>
                        <li>Skills</li>
                        <li>Projects</li>
                        <li>Experiences</li>
                        <li>Backgrounds</li>
                    </ul>
                </div>
                <div class="primary-text">
                    Contact me
                </div>
            </nav>
        </header>
        <div class="fixed w-full z-10 top-1/3 right-0 flex items-center justify-between">
            <div @click="toggleDarkTheme"
                class="w-24 h-24 rounded-full -translate-x-1/2 flex items-center justify-center side-btn shadow-lg cursor-pointer">
                <div class="flex justify-between w-full p-3" :class="{ 'animate-rotate fill-mode-forward': isDark, 'animate-rotateback fill-mode-forward': !isDark }">
                    <Icon name="material-symbols:dark-mode-outline" :class="{'rotate-180': !isDark,'-rotate-180': isDark }"  size="28" />
                    <Icon name="material-symbols:light-mode-outline" size="28" />
                </div>
            </div>
            <div class="flex flex-col space-y-1">
                <button v-for="(item, index) in socmedData" :key="index" class="side-btn p-2">
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