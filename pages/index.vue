<script setup lang="ts">

import { type MainContent } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/main_content", { server: false });

const content: Ref<MainContent | null> = computed(() => data.value ? { ...data.value } : null);

const config = useRuntimeConfig()

const { initHomeAnimations, initHomeContentAnimations } = usePageAnimations()

onMounted(() => {
    initHomeAnimations()
})

watch(status, (newStatus) => {
    if (newStatus === 'success') {
        initHomeContentAnimations()
    }
})

</script>

<template>
  <section class="scroll-smooth page-content">
    <div id="main" class="h-max flex flex-col justify-start gap-4 px-2 sm:px-8 md:px-14 lg:px-24 py-4 sm:py-8 md:py-11 lg:py-16">
      <div>
        <div class="flex items-center gap-2 pb-4 hero-title">
          <h1 class="text-3xl sm:text-4xl md:text-5xl">About Me</h1>
          <BaseRoundDecor />
        </div>
        <MainWavyLoader v-if="status !== 'success'" />

        <p v-if="status === 'success'"
          class="text-sm md:text-lg text-bark hero-description">{{ content?.about_desc }}</p>
      </div>
      <div class="mb-6">
        <h2 v-if="status === 'success'" class="text-2xl sm:text-3xl pb-4">My Specialties</h2>
        <div v-if="status === 'success'" class="flex flex-wrap gap-4 w-full">
          <BaseCardPulsar v-for="(item, index) in content?.specialties" :key="index" :index-color="index" class="w-full sm:w-[48%] specialty-card"
            >
            <template v-slot="{ textStyle }">
              <div class="w-full flex flex-col justify-start p-4 sm:p-6 gap-2">
                <div class="w-12 sm:w-[30%]">
                  <NuxtImg :src="`${item.icon_img}`"></NuxtImg>
                </div>
                <div :class="textStyle" class="space-y-1">
                  <h3 class="text-lg sm:text-xl font-bold">{{ item.title }}</h3>
                  <p class="text-xs sm:text-sm">{{ item.description }} </p>
                </div>
              </div>
            </template>
          </BaseCardPulsar>
        </div>
      </div>
      <div v-if="status === 'success'">
        <h2 class="text-2xl sm:text-3xl pb-4">Languages</h2>
        <div class="space-y-5">
          <LazyBaseLanguage v-for="(item, index) in content?.languages" :key="index"
            :language="item" class="language-item" />
        </div>
      </div>
    </div>
  </section>
</template>
