<script setup lang="ts">

import { type Education } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/educations", { server: false });

const educations: Ref<Education[] | null> = computed(() => data.value ? { ...JSON.parse(data.value) } : null);

onMounted(() => execute());
</script>

<template>
    <section class="px-2 md:px-14 lg:px-24 py-8 md:py-11 lg:py-16 flex md:gap-4">
        <div>
            <h1 :style="{ writingMode: 'vertical-rl' }" class="rotate-180 text-6xl hidden md:block">My Educations</h1>
        </div>
        <div class="flex-grow w-full h-auto">
            <div class="flex items-center gap-2 flex-wrap w-full h-auto" >
                <h1 class="text-3xl block md:hidden">My Educations</h1>
                <BaseRoundDecor class="my-2" />
            </div>
            <MainWavyLoader v-if="status !== 'success'" />
            <p v-if="status === 'success'" class="text-sm md:text-lg pt-2">Adipisicing quis reprehenderit aute aute qui consequat.</p>
            <EducationTimeline v-if="status === 'success'" v-for="(item, index) in educations" :key="index" :education="item" />
        </div>
    </section>
</template>
