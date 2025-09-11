<script setup lang="ts">
import { type ProjectFiles } from '~/stores/model-store';
import VueEasyLightbox from 'vue-easy-lightbox';

const visibleRef = ref(false);
const indexRef = ref(0);
const config = useRuntimeConfig()
const currentIndex = ref(0);
const onHide = () => (visibleRef.value = false);

const props = defineProps<{
    images: ProjectFiles[]
}>()

defineEmits<{
    (e: 'update:images', images: string[], index: number): void
}>()

const prev = () => {
    currentIndex.value = Math.max(0, currentIndex.value - 1);
}
const next = () => {
    currentIndex.value = Math.min(props.images.length - 1, currentIndex.value + 1);
}

const carouselStyle = computed(() => ({
    transform: `translateX(-${currentIndex.value * 200}px)`,
    transition: 'transform 0.3s ease' // optional smooth slide
}))

const showImg = (index: number) => {
    indexRef.value = index;
    visibleRef.value = true;
};


</script>

<template>
    <div class="flex flex-col gap-4 mb-4">
        <div class="flex h-full">
            <!-- {{ carouselClass }} -->
            <!-- <div @click="prev" class="carousel-swipe">
                <Icon name="icon-park-twotone:left-one" size="30" style="color: black" />
            </div> -->
            <div class="overflow-x-auto w-full flex gap-4 no-scrollbar" :style="carouselStyle">
                <NuxtImg v-for="(image, index) in props.images" :key="index"
                    :src="`${config.public.apiBase}/assets/${image.directus_files_id}`"
                    class="w-[200px] h-[150px] object-cover rounded-lg border-2 border-black cursor-pointer"
                    @click="$emit('update:images', props.images.map(img => `${config.public.apiBase}/assets/${img.directus_files_id}`), index)" />
            </div>
            <!-- <div @click="next" class="carousel-swipe">
                <Icon name="icon-park-twotone:right-one" size="30" style="color: black" />
            </div> -->
        </div>
    </div>
    <!-- <VueEasyLightbox class="absolute" :visible="visibleRef"
        :imgs="props.images.map(img => `${config.public.apiBase}/assets/${img.directus_files_id}`)" :index="indexRef"
        @hide="onHide" /> -->

</template>

<style scoped>
.no-scrollbar::-webkit-scrollbar {
    display: none;
    /* For Chrome, Safari, Edge, Opera */
}

.no-scrollbar {
    -ms-overflow-style: none;
    /* For IE and Edge */
    scrollbar-width: none;
    /* For Firefox */
}

.carousel-swipe {
    @apply cursor-pointer z-10 h-[150px] bg-slate-100 mr-2 flex items-center justify-center rounded-lg border-black border-2;
}

</style>