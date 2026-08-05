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
    color: #5C4033;
    background-color: #F0EDE5;
    border: 1px solid #D4C9B8;
    border-radius: 9999px;
    transition: all 0.2s ease;
}

.comic-button:hover {
    background-color: #E8E0D0;
}

</style>