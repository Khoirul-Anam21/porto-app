<script setup lang="ts">

import { type Education } from '../../stores/model-store';
import formatDate from '../../composables/useFormatDate';
import { getCurrentInstance } from "vue";

const props = defineProps<{
    education: Education
}>()

const config = useRuntimeConfig()
const key = getCurrentInstance()?.vnode.key

</script>

<template>
    <BaseTimeline :key-index="key as number">
        <div class="py-4 px-3 sm:py-6 sm:px-4 space-y-3">
            <section class="flex gap-2 md:gap-4">
                <div class="flex justify-center items-start md:items-center basis-[20%] sm:basis-[25%] md:basis-[12%] shrink-0">
                    <NuxtImg :src="`${config.public.education_icon}`"
                        class="w-8 sm:w-10" />
                </div>
                <div class="flex-grow min-w-0">
                    <p class="text-xs sm:text-sm md:text-base break-words">{{ props.education.institution }}</p>
                    <h4 class="text-base sm:text-xl font-bold md:font-normal md:text-3xl break-words">{{ props.education.major }}</h4>
                </div>
            </section>
            <section class="flex flex-col md:flex-row gap-2 md:gap-4 md:items-center">
                <span class="py-1 px-4 sm:px-6 bg-leaf-light/30 text-leaf-dark rounded-xl text-xs md:text-sm w-max">{{ props.education.education_type }}</span>
                <span class="text-xs md:text-sm italic text-bark-light">{{ formatDate(props.education.date_start) }} - {{
                        props.education.date_end ? formatDate(props.education.date_end) : 'Now' }}</span>
            </section>
        </div>
    </BaseTimeline>
</template>
