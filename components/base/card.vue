<script setup lang="ts">

const style = {
    "red": "absolute w-full h-full rounded-2xl bg-leaf-light/30",
    "orange": "absolute w-full h-full rounded-2xl bg-sunlight-light/30",
    "purple": "absolute w-full h-full rounded-2xl bg-sky-light/30",
    "green": "absolute w-full h-full rounded-2xl bg-leaf-light/30",
    "classic": "absolute w-full h-full rounded-2xl bg-paper-dark",
}

const props = defineProps<{
    color: keyof typeof style
}>()



</script>

<template>
    <div class="relative w-[600px] h-[500px]">

        <div class="absolute w-full h-full border border-paper-edge bg-paper-shadow rounded-2xl translate-x-0.5 translate-y-0.5"></div>
        <div  :class="style[props.color]" class="z-50 border border-paper-edge p-2 shadow-paper">
            <slot></slot>
        </div>  
    </div>
</template>