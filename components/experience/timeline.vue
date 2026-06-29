<script setup lang="ts">

import { type Experience, type ExperienceType } from '../../stores/model-store';
import formatDate from '../../composables/useFormatDate';
import { getCurrentInstance } from "vue";

const props = defineProps<{
    experience: Experience,
    experience_type?: ExperienceType
}>()

const config = useRuntimeConfig()

const key = getCurrentInstance()?.vnode.key

const expanded = ref(false)
const detailRef = ref<HTMLElement | null>(null)
const isOverflowing = ref(false)

onMounted(() => {
    if (detailRef.value && detailRef.value.scrollHeight > 160) {
        isOverflowing.value = true
    }
})

</script>

<template>
    <BaseTimeline class="h-auto" :key-index="key as number">
        <div class="py-8 px-5 md:px-10 space-y-4">
        
            <section class="flex gap-3 md:gap-5">
                <div class="flex justify-center items-start md:items-center shrink-0">
                    <NuxtImg :src="`${config.public.experience_icon}`"
                        class="w-12 h-12 md:w-14 md:h-14" />
                </div>
                <div class="flex-grow min-w-0">
                    <p class="text-xs md:text-sm text-gray-500 uppercase tracking-wide">{{ props.experience.company }}</p>
                    <h4 class="text-lg md:text-2xl font-bold mt-1 leading-snug">{{ props.experience.position }}</h4>
                </div>
            </section>
            <section class="flex flex-wrap gap-2 md:gap-3 items-center">
                <span class="py-1.5 px-4 bg-red-200 rounded-lg text-xs font-medium">{{ props.experience_type?.name }}</span>
                <span class="text-xs md:text-sm text-gray-500">{{ formatDate(props.experience.date_start) }} - {{
                    props.experience.date_end ? formatDate(props.experience.date_end) : 'Now' }}</span>
            </section>
            <section class="text-sm md:text-base relative">
                <div ref="detailRef"
                    :class="[
                        'prose prose-slate prose-sm sm:prose-base dark:prose-invert',
                        'prose-li:my-1 prose-p:my-2 prose-ul:my-2 prose-ol:my-2',
                        'prose-img:rounded-lg prose-img:w-[70%]',
                        'prose-headings:text-slate-700 prose-p:text-gray-600',
                        'max-w-none',
                        !expanded && isOverflowing ? 'max-h-48 overflow-hidden' : ''
                    ]"
                    v-html="props.experience.job_detail">
                </div>
                <div v-if="isOverflowing"
                    class="sticky bottom-0 left-0 w-full h-16 bg-gradient-to-t from-pink-50 via-pink-50/80 to-transparent flex items-end justify-center pb-2">
                    <button @click="expanded = !expanded"
                        class="text-xs md:text-sm font-semibold text-dark-turquoise hover:text-turquoise transition-colors">
                        {{ expanded ? '← Show less' : 'Show more →' }}
                    </button>
                </div>
            </section>
        </div>
    </BaseTimeline>
</template>
