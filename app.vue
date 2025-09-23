<script setup lang="ts">
import '~/assets/css/main.css'
import { Analytics } from '@vercel/analytics/nuxt';
import { SpeedInsights } from '@vercel/speed-insights/vue';
const { system, store } = useColorMode()


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


