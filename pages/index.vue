<script setup lang="ts">

import { type MainContent } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/main_content", { server: false });

const content: Ref<MainContent | null> = computed(() => data.value ? { ...JSON.parse(data.value) } : null);

const { getThumbnail } = useDirectusFiles();
onMounted(() => {
  execute();
})






</script>

<template>
  <section class="scroll-smooth">
    <!-- <h1>{{ currentOption }} hei</h1> -->
    <div v-if="status === 'success'" id="main"
      class=" h-max flex flex-col justify-start gap-4 px-8 md:px-14 lg:px-24 py-8 md:py-11 lg:py-16 ">
      <div>
        <div class="flex items-center gap-2 pb-4">
          <h1 class="text-5xl">About Me</h1>
          <MainBaseRoundDecor />
        </div>
        <p class="text-lg">{{ content?.about_desc }}</p>
      </div>
      <div class="mb-6">


        <h2 class="text-3xl pb-4">My Specialties</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
          <MainBaseCardPulsar v-for="(item, index) in content?.specialties" :key="index" :index-color="index">
            <template v-slot="{textStyle}">
              <div class="w-full h-full flex justify-start p-6 gap-2">
                <div class="w-[15%]">
                  <NuxtImg :src="`https://admin.anam6.my.id/assets/${item.flaticon_icon}`"></NuxtImg>
                </div>
                <div :class="textStyle" class="space-y-1">
                  <h3 class="text-xl font-bold">{{ item.title }}</h3>
                  <p>{{ item.description }}</p>
                </div>
              </div>
            </template>
          </MainBaseCardPulsar>
        </div>
      </div>


      <div>
        <h2 class="text-3xl pb-4">Languages </h2>
        <div class="space-y-5">
          <LazyMainBaseLanguage v-for="(item, index) in content?.languages" :key="index" :language="item" />
        </div>
      </div>
    </div>

  </section>
</template>