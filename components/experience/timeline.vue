<script setup lang="ts">

import { type Experience, type ExperienceType } from '../../stores/model-store';
import formatDate from '../../composables/useFormatDate';

const props = defineProps<{
    experience: Experience,
    experience_type: ExperienceType
}>()

const config = useRuntimeConfig()

</script>

<template>
    <BaseTimeline class="h-[210px]">
        <div class="py-6 px-4 md:px-8 space-y-3">
            <section class="flex gap-2 md:gap-4">
                <div class="flex justify-center  items-start  md:items-center basis-[25%] md:basis-[12%]">
                    <NuxtImg :src="`${config.public.apiBase}/assets/e152b968-e69a-4ffe-98e9-462259279d9a`"
                        class="w-full" />
                </div>
                <div class="flex-grow">
                    <p class="text-sm md:text-base">{{ props.experience.company }}</p>
                    <h4 class="text-xl font-bold md:font-normal md:text-4xl">{{ props.experience.position }}</h4>
                </div>
            </section>
            <section class="inline-flex flex-col md:flex-row gap-2 md:gap-4 md:items-center">
                <span class="py-1 px-6 bg-red-200 rounded-xl text-xs md:text-sm w-max">{{ props.experience_type.name }}</span>
                <span class="text-sm md:text-sm italic text-gray-600">{{ formatDate(props.experience.date_start) }} - {{
                        props.experience.date_end ? formatDate(props.experience.date_end) : 'Now' }}</span>
            </section>
        </div>
    </BaseTimeline>
</template>
