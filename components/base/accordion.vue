<script setup lang="ts">

const activeItemId = ref(0)
// const currentIndex: Ref<number | null> = ref(null)
provide('activeItemId', activeItemId);

</script>

<template>
    <div>
        <slot>
        </slot>
    </div>
</template>
