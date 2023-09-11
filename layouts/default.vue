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

</script>

<template>
    <div>
        <header class="bg-white dark:bg-primary-dark w-full p-8 sticky top-0 shadow-lg dark:shadow-none">
            <nav class="flex justify-between items-center">
                <div class="primary-text text-2xl">
                    Lorem <span class="highlight-text">Ipsum</span>
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
                class="w-24 h-24 rounded-full -translate-x-1/2 flex items-center justify-end side-btn shadow-lg cursor-pointer">
                <font-awesome-icon :icon="['fas', 'sun']" size="xl" class="p-4  " />
            </div>
            <div class="flex flex-col space-y-1">
                <button v-for="(item, index) in socmedData" :key="index" class="side-btn p-2">
                    <font-awesome-icon :icon="['fas', 'sun']" />
                </button>
            </div>
        </div>
        <slot></slot>
    </div>
</template>

<script setup lang="ts">
</script>