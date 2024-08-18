<script setup lang="ts">

import { ref, onMounted, onUnmounted } from 'vue';


</script>

<template>
  <header class="basis-[10%] md:basis-[12%] scroll-container" >
    <nav class="flex flex-row space-x-4">
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
</style>