<script setup lang="ts">
import { Analytics } from '@vercel/analytics/nuxt';
import { SpeedInsights } from '@vercel/speed-insights/vue';
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
        <SpeedInsights />
        <NuxtPage />  
      </NuxtLayout>
    </div>
</template>


