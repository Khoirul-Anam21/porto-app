<script setup lang="ts">

import { type MainContent } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/main_content", { server: false });

const content: Ref<MainContent | null> = computed(() => data.value ? { ...JSON.parse(data.value) } : null);

const { getThumbnail } = useDirectusFiles();
onMounted(() => {
  execute();
})


const config = useRuntimeConfig()


</script>

<template>
  <section class="scroll-smooth">
    <!-- <h1>{{ currentOption }} hei</h1> -->
    <div id="main" class=" h-max flex flex-col justify-start gap-4 px-8 md:px-14 lg:px-24 py-8 md:py-11 lg:py-16 ">
      <div>
        <div class="flex items-center gap-2 pb-4">
          <h1 class="text-5xl">About Me</h1>
          <BaseRoundDecor />
        </div>
        <MainWavyLoader v-if="status !== 'success'" />

        <p data-aos="fade-up" data-aos-duration="1000" v-if="status === 'success'" class="md:text-lg text-sm text-gray-800">{{ content?.about_desc }}</p>
      </div>
      <div class="mb-6">


        <h2 v-if="status === 'success'" class="text-3xl pb-4">My Specialties</h2>
        <div v-if="status === 'success'" class="flex flex-wrap gap-4 w-full ">
          <BaseCardPulsar v-for="(item, index) in content?.specialties" :key="index" :index-color="index"
            class="w-full" data-aos="fade-left" :data-aos-delay="index * 100" data-aos-duration="600" >
            <template v-slot="{ textStyle }">
              <div  class="w-full flex flex-col justify-start p-6 gap-2" >
                <div class="w-[30%] md:w-[80%]">
                  <NuxtImg :src="`${config.public.apiBase}/assets/${item.icon}`"></NuxtImg>
                </div>
                <div :class="textStyle" class="space-y-1">
                  <h3 class="text-xl font-bold">{{ item.title }}</h3>
                  <p class="text-sm">{{ item.description }} </p>
                </div>
              </div>
            </template>
          </BaseCardPulsar>
        </div>
      </div>
      <div v-if="status === 'success'">
        <h2 class="text-3xl pb-4">Languages </h2>
        <div class="space-y-5">
          <LazyBaseLanguage v-for="(item, index) in content?.languages" :key="index" data-aos="fade-up" :language="item" />
        </div>
      </div>
    </div>


  </section>
</template>