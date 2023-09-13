
<script setup lang="ts">
import { useStateStore } from '@/stores/index'
 

const stateStore = useStateStore()


</script>

<template>
    <div class="w-full flex items-center justify-between ">
        <section class="space-y-2 w-full">
            <h1 class="text-4xl">I'm <span class="highlight-text text-5xl">Mohammad Khoirul Anam</span></h1>
            <h2 class="text-3xl">Programming Enthusiast</h2>
            <button @click="stateStore.activateSocmed()" class="primary-btn rounded-full">Contact Me</button>
        </section>
        <section class="w-full flex items-center justify-center ">
            <img src="@/assets/images/profile-bw.png" alt="" class="w-full">
        </section>
    </div>
</template>