<script setup lang="ts">

import { ref, onMounted, onUnmounted } from 'vue';


</script>

<template>
  <header class="scroll-container overflow-hidden relative rounded-2xl bg-white border-2 border-black border-opacity-85 py-2 px-3">
    <nav class="flex flex-row gap-2 sm:space-x-4 overflow-x-auto whitespace-nowrap no-scrollbar">
      <BaseNavBtn name="About Me" route="/"/>
      <BaseNavBtn name="Projects" route="/projects"/>
      <BaseNavBtn name="Experiences & Skills" route="/experiences" />
      <BaseNavBtn name="Educations" route="/educations"/>
    </nav>
  </header>
</template>

<style scoped>
/* .grid-container {
  /* Container styles (optional) */

.scroll-container {
  overflow-x: auto;
  overflow-y: hidden;
  white-space: nowrap;
  cursor: grab;
  user-select: none;
}

.grid-wrapper {
  display: flex;
  /* Allow items to flow horizontally */
  touch-action: pan-left pan-right;
  /* Allow drag for touchscreens */
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}

.no-scrollbar {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}
</style>