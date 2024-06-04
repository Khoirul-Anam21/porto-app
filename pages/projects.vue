<script setup lang="ts">

const dataNav = ["All", "Backend", "Frontend", "Fullstack "]


</script>

<template>
  <section class="px-20 pt-14">
    <div class="flex gap-2 items-center pb-2">
      <h1 class="text-5xl">My Projects</h1>
      <MainBaseRoundDecor />
    </div>
    <p class="text-lg">Deserunt ipsum consectetur sint sunt aute ipsum ad.</p>
    <MainBaseOption :data="dataNav" class="my-4" />
  </section>
</template>
  

  
<style scoped>
/* Add your carousel styling here */
</style>
  