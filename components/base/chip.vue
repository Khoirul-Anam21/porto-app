<script setup lang="ts">

const props = defineProps<{
    value: string
}>()

</script>
<template>
    <span class="comic-button px-6 py-1 text-[8pt] sm:text-[10pt] md:text-xs">{{ value }}</span>
</template>

<style scoped>
.comic-button {
    display: inline-block;
    text-align: center;
    text-decoration: none;
    color: #0b0b0b;
    background-color: #ffffff;
    border: 2px solid #000;
    border-radius: 9999px;
    box-shadow: 2px 2px 0px #000;
    transition: all 0.3s ease;
}

</style>