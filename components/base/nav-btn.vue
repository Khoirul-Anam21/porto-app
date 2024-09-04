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
        class=" border border-slate-900 border-b-4 font-medium sm:overflow-hidden relative px-4 py-2 rounded-2xl  hover:border-t-4 hover:border-b active:opacity-75 outline-none duration-300 group"
        :class="{ 'bg-slate-900 text-slate-200': params === props.route, 'bg-slate-50 text-slate-800': params !== props.route }">
        <span
            class="shadow-neutral-400 absolute -top-[150%] left-0 inline-flex w-full h-[5px] rounded-md opacity-50 sm:group-hover:top-[150%] duration-500 shadow-[0_0_10px_10px_rgba(0,0,0,0.3)]"></span>
        <p class="text-sm sm:text-base">
            {{ props.name }}
        </p>
    </NuxtLink>
</template>