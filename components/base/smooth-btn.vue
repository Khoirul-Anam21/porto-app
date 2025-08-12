<script setup lang="ts">
defineEmits(['clicked'])

</script>

<template>
    <button @click="$emit('clicked')" class="comic-button"><slot></slot></button>
</template>

<style scoped>
.comic-button {
    display: inline-block;
    padding: 5px 20px;
    font-size: 15px;
    /* font-weight: bold; */
    text-align: center;
    text-decoration: none;
    color: #3f0000;
    background-color: #fecece;
    border: 2px solid #000;
    border-radius: 10px;
    box-shadow: 3px 3px 0px #000;
    transition: all 0.3s ease;
    cursor: pointer;
}

.comic-button:hover {
    background-color: #fff;
    color: #ff5252;
    border: 2px solid #ff5252;
    box-shadow: 5px 5px 0px #ff5252;
}

.comic-button:active {
    background-color: #fcf414;
    box-shadow: none;
    transform: translateY(4px);
}
</style>