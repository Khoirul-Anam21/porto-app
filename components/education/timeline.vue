<script setup lang="ts">

import { type Education } from '../../stores/model-store';
import formatDate from '../../composables/useFormatDate';

const props = defineProps<{
    education: Education
}>()

</script>

<template>
    <BaseTimeline class="h-full max-h-[240px] md:h-[230px]">
        <div class="py-6 px-4 space-y-3">
            <section class="flex gap-2 md:gap-4">
                <div class="flex justify-center items-start md:items-center basis-[25%] md:basis-[12%]">
                    <NuxtImg src="https://admin.anam6.my.id/assets/4b9f5961-2e07-4961-b0a6-1392ab422234"
                        class="w-full" />
                </div>
                <div class="flex-grow">
                    <p class="text-sm md:text-base" >{{ props.education.institution }}</p>
                    <h4 class="text-xl font-bold md:font-normal md:text-2xl">{{ props.education.major }}</h4>
                </div>
            </section>
            <section class="inline-flex flex-col md:flex-row gap-2 md:gap-4 md:items-center">
                <span class="py-1 px-6 bg-red-200 rounded-xl text-xs md:text-sm w-max">{{ props.education.education_type }}</span>
                <span class="text-xs md:text-sm italic text-gray-600">{{ formatDate(props.education.date_start) }} - {{
                        props.education.date_end ? formatDate(props.education.date_end) : 'Now' }}</span>
            </section>
        </div>
    </BaseTimeline>
</template>
