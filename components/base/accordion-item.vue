<script setup lang="ts">


const props = defineProps<{
    itemId: number,
}>()


const activeItemId = inject('activeItemId') as Ref<number>;

const contentRef = ref();
const isActive = ref(false);
const height = ref(0)
const PADDING_HEIGHT = 32;

watch(activeItemId, () => {
    // console.log(newVal);
    nextTick(updateHeight);
    updateHeight()
    if (height.value === 0) {
        isActive.value = false
    }
})

const toggleCollapse = () => {
    console.log(activeItemId.value);

    isActive.value = !isActive.value

    if (activeItemId.value !== props.itemId) {
        activeItemId.value = props.itemId;
    } else {
        activeItemId.value = 0
    }
    nextTick(updateHeight);
}

const updateHeight = () => {
    if (isActive.value && height.value === 0) {
        height.value = contentRef.value.scrollHeight + PADDING_HEIGHT
    } else {
        height.value = 0
    }
}



</script>

<template>
    <div class="relative rounded-2xl my-4">
        <div class="w-full h-full card-container pl-4 py-4 pr-2 relative" :class="{ '-translate-x-2 -translate-y-2': isActive }">
            <button @click="toggleCollapse()" class="flex w-full justify-between items-center">
                <slot name="header"></slot>
                <Icon name="material-symbols:chevron-right-rounded" size="28"  :class="{
                    'rotate-90 transform-gpu transition-all duration-200 delay-200': isActive,
                    'rotate-0 transform-gpu transition-all duration-200 delay-200': !isActive,
                }"></Icon name="">
            </button>
            <div ref="contentRef" :style="{
                height: `${height}px`
            }" class="transform-gpu overflow-hidden border-slate-300 px-2 transition-all duration-200 "
                :class="{ 'p-2': isActive }">
                <slot></slot>
            </div>
        </div>
    </div>
</template>

<style scoped>
.card-container {
    @apply bg-none border-black border-2 w-full h-full rounded-2xl transform-gpu transition-all duration-200 delay-200;
}
</style>