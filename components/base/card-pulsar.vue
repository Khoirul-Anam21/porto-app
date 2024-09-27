<script setup lang="ts">

const styles = ["absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-red-100",
    "absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-orange-100",
    "absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-purple-100",
    "absolute w-full h-full rounded-2xl translate-x-2 translate-y-2 bg-green-100"
];

const textStyles = [' text-red-900', 'text-orange-900', 'text-purple-900', 'text-green-900'];


const props = defineProps<{
    indexColor: number
}>();



const numIndex = computed(() => {
    if (props.indexColor >= styles.length) {
        return 0;
    }
    return props.indexColor;
});

</script>

<template>
    <div class="relative md:w-[48%] w-full md:max-w-[400px] h-max min-h-[300px] sm:min-h-[250px] md:min-h-[280px]">
        <div class="absolute z-10 w-full h-full border-2 border-black rounded-2xl bg-none">
            <slot :textStyle="textStyles[numIndex]"></slot>
        </div>
        <div :class="styles[numIndex]" ref="contentRef">
        </div>
    </div>
</template>