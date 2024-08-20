<script setup lang="ts">

import { type Experience, type Skill } from '../stores/model-store';

const { status: exStatus , data: exData, execute: exExecute } = useLazyFetch("/api/experiences", { server: false });
const { status: skStatus, data: skData, execute: skExecute } = useLazyFetch("/api/skills", { server: false });

const experiences: Ref<Experience[] | null> = computed(() => exData.value ? [...JSON.parse(exData.value)]: null);
const skills: Ref<Skill[] | null> = computed(() => skData.value ? [...JSON.parse(skData.value)]: null);

onMounted(() => {
    exExecute();
    skExecute();
});


</script>
<template>
    <section class=" flex">
        <div class="basis-2/3 py-8 md:py-11 lg:py-16">
            <div class="flex items-center h-max pb-10">
                <div class="relative  h-10 flex items-center mr-4">
                    <div class="w-28 h-1 bg-slate-500"></div>
                    <BaseRoundDecor class="absolute right-0 border-4 border-white scale-150" />
                </div>
                <h1 class="text-5xl">My Experiences</h1>
            </div>
            <div class="px-8 md:px-14 lg:px-22">
                <ExperienceTimeline v-for="(item, index) in experiences" :key="index" :experience="item" />
            </div>
        </div>
        <div class="flex ">
            <div v-if="skills">
                <MainSkillsets :skills="skills" />
            </div>
            <div class="flex flex-col items-center mx-10">
                <div class="relative flex flex-col items-center mb-4">
                    <div class="h-28 w-1 bg-slate-500"></div>
                    <BaseRoundDecor class="absolute bottom-0 border-4 border-white scale-150" />
                </div>
                <h1 class="text-5xl" :style="{ writingMode: 'vertical-rl' }">My Skills</h1>
            </div>
        </div>
    </section>
</template>