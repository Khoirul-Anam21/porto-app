<script setup lang="ts">

const props = defineProps<{
    keyIndex: number
}>();

const mainDuration = 500; // base duration for AOS animations

</script>
<template>
    <div class="w-full flex flex-row gap-4 md:gap-8 px-4 pt-2">
        <div data-aos="zoom-in-up" :data-aos-duration="mainDuration + (keyIndex * 200)" class="flex flex-col items-center relative shrink-0">
            <div class="w-6 md:w-10 h-6 md:h-10 bg-leaf rounded-full relative mt-1 shadow-md">
                <div class="w-6 md:w-10 h-6 md:h-10 bg-leaf-light rounded-full -translate-x-1 -translate-y-1"></div>
            </div>
            <div class="flex-1 my-1 timeline-organic-line"></div>
        </div>
        <div data-aos="fade-left" data-aos-delay="100" :data-aos-duration="mainDuration + (keyIndex * 200)" class="flex-grow min-w-0 pb-6">
            <div class="w-full paper-card paper-card-raised p-4">
                <slot></slot>
            </div>
        </div>
    </div>
</template>

<style scoped>

.timeline-organic-line {
    height: 100%;
    width: 3px;
    background: linear-gradient(180deg, #6B8F3C 0%, #D4C9B8 100%);
    border-radius: 2px;
}

</style>