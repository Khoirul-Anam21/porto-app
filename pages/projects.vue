<script setup lang="ts">

import { type Education, type Project, type ProjectType } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/projects", { server: false });

const contents: Ref<Project[] | null> = computed(() => data.value ?  [...JSON.parse(data.value).projects]  : null);
const types: Ref<ProjectType[] | null> = computed(() => data.value ?  [...JSON.parse(data.value).types]  : null);




onMounted(() => execute());


</script>

<template>
  <section class="px-1 sm:px-10 md:px-20 pt-2 sm:pt-8 md:pt-14">
    <div class="flex gap-2 items-center pb-2">
      <h1 class="text-3xl sm:text-4xl md:text-5xl">My Projects</h1>
      <BaseRoundDecor />
    </div>
    <MainWavyLoader v-if="status !== 'success'" />
    <p v-if="status === 'success'" class="text-base md:text-lg">Deserunt ipsum consectetur sint sunt aute ipsum ad.</p>
    <br class="hidden md:block" >
    <MainProjectList v-if="status === 'success'" :projects="contents" :project-types="types" />
  </section>
</template>


<style scoped>
/* Add your carousel styling here */
</style>