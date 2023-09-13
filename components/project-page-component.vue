<script setup lang="ts">
import ProjectCard from './main/project-card.vue';


</script>

<template>
    <div class="w-full flex items-center justify-center">
      <div class="flex space-x-4">
        <ProjectCard v-for="(item, index) in projectData" :key="index" :project="item"/>
      </div>
    </div>
  </template>
  

  
  <style scoped>
  /* Add your carousel styling here */
  </style>
  