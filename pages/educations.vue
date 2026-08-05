<script setup lang="ts">

import { type Education } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/educations", { server: false });

const educations: Ref<Education[] | null> = computed(() => data.value ? [ ...data.value ] : null);

const { initEducationsAnimations, initEducationsContentAnimations } = usePageAnimations()

onMounted(() => {
    execute();
    initEducationsAnimations()
});

watch(status, (newStatus) => {
    if (newStatus === 'success') {
        initEducationsContentAnimations()
    }
})

</script>

<template>
    <section class="px-2 md:px-14 lg:px-24 py-4 sm:py-8 md:py-11 lg:py-16 flex md:gap-4 page-content">
        <div>
            <h1 :style="{ writingMode: 'vertical-rl' }" class="rotate-180 text-6xl hidden md:block educations-title">My Educations</h1>
        </div>
        <div class="flex-grow w-full h-auto min-w-0">
            <div class="flex items-center gap-2 flex-wrap w-full h-auto">
                <h1 class="text-2xl sm:text-3xl block md:hidden educations-title">My Educations</h1>
                <BaseRoundDecor class="my-2" />
            </div>
            <MainWavyLoader v-if="status !== 'success'" />
            <p v-if="status === 'success'" class="text-sm md:text-lg pt-2 educations-subtitle">Education is the key to unlock our potential</p>
            <div v-if="status === 'success'">
                <EducationTimeline
                    v-for="(item, index) in educations?.sort((a, b) => b.sequence - a.sequence)" :key="index"
                    :education="item" class="education-timeline-item" />
            </div>
        </div>
    </section>
</template>
