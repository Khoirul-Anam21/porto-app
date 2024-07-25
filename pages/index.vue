<script setup lang="ts">

import { type MainContent } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/main_content", { server: false });

const content: Ref<MainContent | null> = computed(() => data.value ? {...JSON.parse(data.value)}: null);

onMounted(() => {
  execute();
})



</script>

<template>
  <section class="scroll-smooth">
    <!-- <h1>{{ currentOption }} hei</h1> -->
    <div v-if="status === 'success'" id="main" class=" h-max flex flex-col justify-start gap-4 px-8 md:px-14 lg:px-24 py-8 md:py-11 lg:py-16 ">
      <div>
        <div class="flex items-center gap-2 pb-4">
          <h1 class="text-5xl">About Me</h1>
          <MainBaseRoundDecor />
        </div>
        <p class="text-lg">{{ content?.about_desc }}</p>
      </div>
      <div class="mb-6">
        <h2 class="text-3xl pb-4">My Specialty</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
          <MainBaseCardPulsar color="red" />
          <MainBaseCardPulsar color="green" />
          <MainBaseCardPulsar color="purple" />
          <MainBaseCardPulsar color="orange" />
        </div>
      </div>
      <div>
        <h2 class="text-3xl pb-4">Languages {{ content?.languages }}</h2>
        <div class="space-y-5">

          <div class="flex ">
            <div class="w-12 h-2 my-3 mr-4 bg-orange-200 border-gray-900 border"></div>
            <div class="space-y-2">
              <h3 class="text-2xl text-gray-600">English</h3>
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
            </div>
          </div>
          <div class="flex ">
            <div class="w-12 h-2 my-3 mr-4 bg-orange-200 border-gray-900 border"></div>
            <div class="space-y-2">
              <h3 class="text-2xl text-gray-600">Indonesia</h3>
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
            </div>
          </div>
          <div class="flex ">
            <div class="w-12 h-2 my-3 mr-4 bg-orange-200 border-gray-900 border"></div>
            <div class="space-y-2">
              <h3 class="text-2xl text-gray-600">Madurese</h3>
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
              <MainBaseChip class="mr-3" />
            </div>
          </div>
        </div>
      </div>
    </div>

  </section>
</template>