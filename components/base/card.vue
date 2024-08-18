<script setup lang="ts">

const style = {
    "red": "absolute w-full h-full rounded-2xl  bg-red-100",
    "orange": "absolute w-full h-full rounded-2xl bg-orange-100",
    "purple": "absolute w-full h-full rounded-2xl bg-purple-100",
    "green": "absolute w-full h-full rounded-2xl bg-green-100",
    "classic": "absolute w-full h-full rounded-2xl bg-slate-50",
}

const props = defineProps<{
    color: keyof typeof style
}>()



</script>

<template>
    <div class="relative w-[600px] h-[500px]">

        <div class="absolute w-full h-full border-2 border-black bg-black rounded-2xl bg-none translate-x-1 translate-y-1"></div>
        <div  :class="style[props.color]" class="z-50 border-2 border-black p-2">
            <slot></slot>
        </div>  
    </div>
</template>