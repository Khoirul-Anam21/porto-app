<script setup lang="ts">
import { Analytics } from '@vercel/analytics/nuxt';
const { system, store } = useColorMode()

watch(system, (newv, old) => {
  console.log(newv);
});

// const mode = computed(() => store.value === 'auto' ? system.value : store.value)

// const layout = 'blank';
</script>



<template>
    <div class="scroll-smooth">
      <NuxtLayout>
        <Analytics />
        <NuxtPage />  
      </NuxtLayout>
    </div>
</template>


