<script setup lang="ts">

import { type Skill } from '../../stores/model-store';

const props = defineProps<{
    skills: Skill[]
}>()

</script>

<template>
    <section class="flex gap-2 h-full">
        <div class="flex flex-col overflow-hidden space-y-2 h-full group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused">
                <BaseVerticalCard type="normal" v-for="(item, index) in props.skills" :key="index" :title="item.title" :icon-str="item.icon_url" />
            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused" aria-hidden="true">
                <BaseVerticalCard type="normal" v-for="(item, index) in props.skills" :key="index" :title="item.title" :icon-str="item.icon_url"  />
            </div>
        </div>
        <div class="flex flex-col overflow-hidden space-y-2 h-full group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused">
                <BaseVerticalCard type="reverse" v-for="(item, index) in props.skills" :key="index" :title="item.title" :icon-str="item.icon_url"/>
            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused" aria-hidden="true">
                <BaseVerticalCard type="reverse" v-for="(item, index) in props.skills" :key="index" :title="item.title" :icon-str="item.icon_url"/>
            </div>
        </div>
    </section>
</template>
