<script setup lang="ts">

import { type Education, type Project, type ProjectType } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/projects", { server: false });

const contents: Ref<Project[] | null> = computed(() => data.value ? [...data.value.projects] : null);
const types: Ref<ProjectType[] | null> = computed(() => data.value ? [...data.value.types] : null);

const { initProjectsAnimations, initProjectsContentAnimations } = usePageAnimations()

onMounted(() => {
    execute();
    initProjectsAnimations()
});

watch(status, (newStatus) => {
    if (newStatus === 'success') {
        initProjectsContentAnimations()
    }
})

</script>

<template>
  <section class="px-2 sm:px-10 md:px-20 pt-2 sm:pt-8 md:pt-14 page-content">
    <div class="flex gap-2 items-center pb-2 projects-title">
      <h1 class="text-2xl sm:text-4xl md:text-5xl">My Projects</h1>
      <BaseRoundDecor />
    </div>
    <MainWavyLoader v-if="status !== 'success'" />
    <p v-if="status === 'success'" class="text-sm sm:text-base md:text-lg projects-subtitle">Every task is a
      chance to learn and grow</p>
    <br class="hidden md:block">
    <MainProjectList v-if="status === 'success'" :projects="contents" :project-types="types" />
  </section>
</template>


<style scoped>
</style>
