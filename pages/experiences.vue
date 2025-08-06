<script setup lang="ts">

import { type Experience, type Skill, type ExperienceType } from '../stores/model-store';

const { status: exStatus, data: exData, execute: exExecute } = useLazyFetch("/api/experiences", { server: false });
const { status: skStatus, data: skData, execute: skExecute } = useLazyFetch("/api/skills", { server: false });

const experiences: Ref<Experience[] | null> = computed(() => exData.value ? [...JSON.parse(exData.value).experiences] : null);
const experience_types: Ref<ExperienceType[] | null> = computed(() => exData.value ? [...JSON.parse(exData.value).types] : null);
const skills: Ref<Skill[] | null> = computed(() => skData.value ? [...JSON.parse(skData.value)] : null);

onMounted(() => {
    exExecute();
    skExecute();
});

// get experience types by id
const getExperienceTypeById = (id: number) => {
    return experience_types.value?.find(type => type.id === id);
}


</script>
<template>
    <section class="flex flex-col md:flex-row">
        <div class="basis-2/3 py-2 md:py-11 lg:py-16">
            <div class="flex flex-col md:flex-row  md:items-center h-max pb-4 px-2 md:pb-10">
                <div class="relative h-10 inline-flex w-max items-center mr-4">
                    <div class="w-28 h-1 bg-slate-500"></div>
                    <BaseRoundDecor class="absolute right-0 border-4  border-white scale-150" />
                </div>
                <h1 class="text-5xl">My Experiences</h1>
            </div>
            <MainWavyLoader v-if="exStatus !== 'success'" />
            <div v-if="exStatus === 'success'" class="md:px-14 lg:px-22">
                <ExperienceTimeline v-for="(item, index) in experiences?.sort((a, b) => b.sequence - a.sequence)"  :key="index" :experience="item" :experience_type="getExperienceTypeById(item.job_type)" />
            </div>
        </div>
        <div class="flex flex-col-reverse md:flex-row  overflow-hidden">
            <div v-if="skills" class="relative h-[300px] md:h-auto">
                <MainSkillsets :skills="skills" />
            </div>
            <div class="flex h-max flex-col items-start md:items-center mx-10">
                <div class="relative flex md:flex-col w-full mt-4 items-center mb-4">
                    <div class="h-1 w-28 md:h-28 md:w-1 bg-slate-500"></div>
                    <BaseRoundDecor class="absolute md:bottom-0 border-4 border-white scale-150" />
                </div>
                <h1 class="text-5xl text-vertical">My Skills</h1>
            </div>
        </div>
    </section>
</template>

<style scoped>
.text-vertical {
    writing-mode: horizontal-tb
}

@media (min-width: 800px) {
    .text-vertical {
        writing-mode: vertical-rl
    }
}
</style>