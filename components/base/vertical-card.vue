<script setup lang="ts">

const props = defineProps<{
    type: string
    title: string
    iconStr: string
}>();

const config = useRuntimeConfig()

</script>

<template>
    <div :class="{'flex-col-reverse': props.type === 'reverse', 'flex-col': props.type === 'normal'}"
        class="skill-card bg-paper-dark border border-paper-edge gap-2 pt-1 pb-2 pl-1 pr-2 rounded-xl inline-flex items-center whitespace-nowrap h-max shadow-paper">
        <div class="w-11 h-11 relative">
            <div class="absolute w-full h-full bg-leaf rounded-lg translate-x-0.5 translate-y-0.5"></div>
            <div
                class="absolute w-full h-full bg-paper border border-paper-edge rounded-lg flex p-1 items-center justify-center">
                <NuxtImg class="rotate-90 md:rotate-0" :src="`${props.iconStr}`" alt="" srcset=""/>
            </div>
        </div>
        <p :style="{writingMode: 'vertical-rl'}" class="py-1 text-bark">{{ props.title }}</p>
    </div>
</template>