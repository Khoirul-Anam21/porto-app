<script setup lang="ts">

const props = defineProps<{
    name: string,
    route: string
}>();

const route = useRoute();

const params = computed(() => route.path);




</script>

<template>
    <NuxtLink :to="`${props.route}`"
        class="font-medium sm:overflow-hidden relative px-4 py-2 rounded-xl transition-all duration-200"
        :class="{ 'bg-leaf text-white shadow-md': params === props.route, 'bg-paper-dark text-bark hover:bg-paper-edge': params !== props.route }">
        <p class="text-sm sm:text-base">
            {{ props.name }}
        </p>
    </NuxtLink>
</template>