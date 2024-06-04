<script setup lang="ts">

const style = {
    "red": "absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-red-100",
    "orange": "absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-orange-100",
    "purple": "absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-purple-100",
    "green": "absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-green-100"
}

const props = defineProps<{
    color: keyof typeof style
}>()



</script>

<template>
    <div class="relative max-w-[400px] h-[200px]">
        <div class="absolute z-10 w-full h-full border-2 border-black rounded-2xl bg-none">
        </div>
        <div :class="style[props.color]"></div>
    </div>
</template>