<script setup lang="ts">
import ProjectCard from './main/project-card.vue';


</script>

<template>
  <div class="flex flex-col items-center space-y-2 pb-8">
    <h1 class="text-3xl">My Projects</h1>
    <div class="w-14 py-[2px] bg-turquoise"></div>
  </div>
  <div class="w-full flex flex-col items-start  justify-center overflow-auto">
    <div class="flex space-x-4">
      <ProjectCard v-for="(item, index) in projectData" :key="index" :project="item" />
    </div>
  </div>
</template>
  

  
<style scoped>
/* Add your carousel styling here */
</style>
  