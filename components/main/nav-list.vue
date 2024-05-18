<script setup lang="ts">

import { ref, onMounted, onUnmounted } from 'vue';


</script>

<template>
  <section class="basis-[10%] md:basis-[12%] scroll-container" >
    <div class="flex flex-row space-x-4">
      <MainBaseNavBtn />
      <MainBaseNavBtn />
      <MainBaseNavBtn />
      <MainBaseNavBtn />
      <MainBaseNavBtn />
    </div>
  </section>
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