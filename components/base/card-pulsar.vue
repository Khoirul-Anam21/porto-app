<script setup lang="ts">

const styles = ["absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-leaf-light/30",
    "absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-sky-light/30",
    "absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-sunlight-light/30",
    "absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-paper-shadow"
];

const textStyles = [' text-leaf-dark', 'text-bark', 'text-bark', 'text-bark'];


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
    <div class="relative md:w-[48%] w-full md:max-w-[400px] h-max overflow-hidden rounded-2xl">
        <div :class="styles[numIndex]"></div>
        <div class="relative z-10 w-full border border-paper-edge rounded-2xl bg-paper paper-card-raised">
            <slot :textStyle="textStyles[numIndex]"></slot>
        </div>
    </div>
</template>