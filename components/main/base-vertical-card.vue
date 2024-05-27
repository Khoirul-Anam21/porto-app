<script setup lang="ts">

defineProps<{
    type: string
}>();

</script>

<template>
    <div :class="{'flex-col-reverse': type === 'reverse', 'flex-col': type === 'normal'}"
        class=" bg-yellow-100 border-black border gap-2 pt-1 pb-2 pl-1 pr-2 rounded-xl inline-flex items-center whitespace-nowrap h-max">
        <div class="w-11 h-11 relative">
            <div class="absolute w-full h-full bg-black rounded-lg translate-x-1 translate-y-1"></div>
            <div
                class="absolute w-full h-full bg-red-200 border border-black rounded-lg flex items-center justify-center">
                <div class="">A</div>
            </div>
        </div>
        <p :style="{writingMode: 'vertical-rl'}">Hello Im here</p>
    </div>
</template>