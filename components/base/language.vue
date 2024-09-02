<script setup lang="ts">
import { type Language } from '../../stores/model-store';

const props = defineProps<{
    language: Language
}>()

</script>

<template>
    <div class="flex ">
        <div class="w-12 h-2 my-3 mr-4 bg-orange-200 border-gray-900 border"></div>
        <div class="space-y-2">
            <h3 class="text-2xl text-gray-600">{{ language.name }}</h3>
            <BaseChip class="mr-3 flex flex-wrap" v-for="(item, index) in language.level" :key="index" :value="item.level"/>
        </div>
    </div>
</template>