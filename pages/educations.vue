<script setup lang="ts">

import { type Education } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/educations", { server: false });

const educations: Ref<Education[] | null> = computed(() => data.value ? { ...JSON.parse(data.value) } : null);

onMounted(() => execute());
</script>

<template>
    <section class="px-8 md:px-14 lg:px-24 py-8 md:py-11 lg:py-16 flex gap-4">
        <div>
            <h1 :style="{ writingMode: 'vertical-rl' }" class="rotate-180 text-6xl">My Educations</h1>
        </div>
        <div class="flex-grow">
            <BaseRoundDecor class="my-2" />
            <p class="text-lg pt-2">Adipisicing quis reprehenderit aute aute qui consequat.</p>
            <EducationTimeline v-for="(item, index) in educations" :key="index" :education="item" />
        </div>
    </section>
</template>
