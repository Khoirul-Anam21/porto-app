<script setup lang="ts">

import { type Experience } from '../../stores/model-store';
import formatDate from '../../composables/useFormatDate';

const props = defineProps<{
    experience: Experience
}>()

</script>

<template>
    <BaseTimeline class="h-[190px]">
        <div class="py-6 px-8 space-y-3">
            <section class="flex gap-4">
                <div class="flex justify-center items-center basis-[15%]">
                    <NuxtImg src="https://admin.anam6.my.id/assets/abe4ca22-0c0d-4a29-8cc7-7e672ec50a89"
                        class="w-full" />
                </div>
                <div class="flex-grow">
                    <p>{{ props.experience.company }}</p>
                    <h4 class="text-2xl">{{ props.experience.position }}</h4>
                </div>
            </section>
            <section class="inline-flex gap-4 items-center">
                <span class="py-1 px-6 bg-red-200 rounded-xl text-sm">{{ props.experience.types }}</span>
                <span class="text-sm italic text-gray-600">{{ formatDate(props.experience.date_start) }} - {{
                        props.experience.date_end ? formatDate(props.experience.date_end) : 'Now' }}</span>
            </section>
        </div>
    </BaseTimeline>
</template>
