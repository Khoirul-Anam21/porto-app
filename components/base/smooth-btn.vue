<script setup lang="ts">
defineEmits(['clicked'])

</script>

<template>
    <button @click="$emit('clicked')" class="comic-button"><slot></slot></button>
</template>

<style scoped>
.comic-button {
    display: inline-block;
    padding: 8px 24px;
    font-size: 15px;
    text-align: center;
    text-decoration: none;
    color: white;
    background: linear-gradient(135deg, #6B8F3C 0%, #4A6B28 100%);
    border: none;
    border-radius: 9999px;
    box-shadow: 0 2px 8px rgba(107, 143, 60, 0.3);
    transition: all 0.2s ease;
    cursor: pointer;
}

.comic-button:hover {
    box-shadow: 0 4px 12px rgba(107, 143, 60, 0.4);
    transform: translateY(-1px);
}

.comic-button:active {
    transform: translateY(1px);
    box-shadow: 0 1px 4px rgba(107, 143, 60, 0.3);
}
</style>