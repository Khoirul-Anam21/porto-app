
<script setup lang="ts">
import { useStateStore } from '@/stores/index'


const stateStore = useStateStore()

const goTo = (reference: string) => {
    const element = document.getElementById(reference);
    if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
    }
}

const openCV = () => {
    window.open('https://docs.google.com/document/d/1B09vjlvs6BRPIiXFsgUlOEos6JMNCoZjHxe3PVf8WVA/edit', '_blank')
}


</script>

<template>
    <div class="w-full flex items-center justify-between ">
        <section class="space-y-2 w-full">
            <h1 class="text-4xl">I'm <span class="highlight-text text-5xl">Mohammad Khoirul Anam</span></h1>
            <h2 class="text-3xl">Programming Enthusiast</h2>
            <button @mouseenter="stateStore.activateSocmed()" @mouseleave="stateStore.stopWiggle()" @click="goTo('contact')"
                class="primary-btn rounded-full">Contact Me</button>
            <button @click="openCV()" class="ml-4 hover:underline">My CV<Icon name="material-symbols:chevron-right" size="24" class="mb-[3px]" />
            </button>
        </section>
        <section class="w-full flex items-center justify-center ">
            <img src="@/assets/images/profile-bw.png" alt="" class="w-full">
        </section>
</div></template>