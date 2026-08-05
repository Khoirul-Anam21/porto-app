<script setup lang="ts">

import { ref, onMounted, onUnmounted } from 'vue';


</script>

<template>
  <header class="relative rounded-2xl bg-paper border border-paper-edge py-2 px-3 paper-card-raised">
    <nav class="flex flex-row gap-2 sm:space-x-4 overflow-x-auto whitespace-nowrap no-scrollbar">
      <BaseNavBtn name="About Me" route="/"/>
      <BaseNavBtn name="Projects" route="/projects"/>
      <BaseNavBtn name="Experiences & Skills" route="/experiences" />
      <BaseNavBtn name="Educations" route="/educations"/>
    </nav>
  </header>
</template>

<style scoped>
.no-scrollbar::-webkit-scrollbar {
  display: none;
}

.no-scrollbar {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}
</style>