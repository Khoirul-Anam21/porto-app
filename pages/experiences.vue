<script setup lang="ts">

import { type Experience, type Skill, type ExperienceType } from '../stores/model-store';

const { status: exStatus, data: exData, execute: exExecute } = useLazyFetch("/api/experiences", { server: false });
const { status: skStatus, data: skData, execute: skExecute } = useLazyFetch("/api/skills", { server: false });

const experiences: Ref<Experience[] | null> = computed(() => exData.value ? [...exData.value.experiences] : null);
const experience_types: Ref<ExperienceType[] | null> = computed(() => exData.value ? [...exData.value.types] : null);
const skills: Ref<Skill[] | null> = computed(() => skData.value ? [...skData.value] : null);

const drawerOpen = ref(true)
const { initExperiencesAnimations, initExperiencesContentAnimations } = usePageAnimations()

const getExperienceTypeById = (id: number) => {
    return experience_types.value?.find(type => type.id === id);
}

onMounted(() => {
    exExecute();
    skExecute();
    initExperiencesAnimations()
});

watch([exStatus, skStatus], ([exStat, skStat]) => {
    if (exStat === 'success' || skStat === 'success') {
        initExperiencesContentAnimations()
    }
})

</script>
<template>
    <section class="relative flex flex-col page-content">
        <div class="py-2 md:py-11 lg:py-16 min-w-0 transition-all duration-[400ms] ease-[cubic-bezier(0.4,0,0.2,1)]"
             :class="{ 'md:pr-[140px]': drawerOpen }">
            <div class="flex flex-col md:flex-row md:items-center h-max pb-4 px-2 md:pb-10">
                <div class="relative h-10 inline-flex w-max items-center mr-4">
                    <div class="w-28 h-1 bg-paper-edge"></div>
                    <BaseRoundDecor class="absolute right-0 border-4 border-paper scale-150" />
                </div>
                <div>
                    <h1 class="text-3xl sm:text-4xl md:text-5xl experiences-title">My Experiences</h1>
                    <p class="text-sm md:text-lg pt-2 experiences-subtitle">Experience is the best teacher</p>
                </div>
            </div>

            <MainWavyLoader v-if="exStatus !== 'success'" />
            <div v-if="exStatus === 'success'" class="px-2 md:px-14 lg:px-22">
                <ExperienceTimeline v-for="(item, index) in experiences?.sort((a, b) => b.sequence - a.sequence)"
                    :key="index" :experience="item" :experience_type="getExperienceTypeById(item.job_type)" />
            </div>
        </div>

        <MainSkillDrawer
            v-if="skills"
            :skills="skills"
            @toggle="drawerOpen = $event"
        />
    </section>
</template>
