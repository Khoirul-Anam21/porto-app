<script setup lang="ts">

import { type Education, type Project, type ProjectType } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/projects", { server: false });
const dataNav = ["All", "Backend", "Frontend", "Fullstack "]

const contents: Ref<Project[] | null> = computed(() => data.value ? { ...JSON.parse(data.value).projects } : null);
const types: Ref<ProjectType | null> = computed(() => data.value ? { ...JSON.parse(data.value).types } : null);


onMounted(() => execute());


</script>

<template>
  <section class="px-20 pt-14">
    <div class="flex gap-2 items-center pb-2">
      <h1 class="text-5xl">My Projects</h1>
      <MainBaseRoundDecor />
    </div>
    <p class="text-lg">Deserunt ipsum consectetur sint sunt aute ipsum ad.</p>
    {{ contents }}
    <br>
    {{ types }}
    <MainBaseOption :data="dataNav" class="my-4" />
  </section>
</template>


<style scoped>
/* Add your carousel styling here */
</style>