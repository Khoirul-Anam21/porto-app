<script setup lang="ts">

import { type Skill } from '../../stores/model-store';

const props = defineProps<{
    skills: Skill[]
}>()

</script>

<template>
    <section class="inline-flex gap-8">
        <div class="flex flex-col overflow-hidden space-y-2 h-screen group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused">
                <BaseVerticalCard type="normal" v-for="(item, index) in skills" :key="index" :title="item.title" :icon-str="item.skill_icon_title" />
            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused" aria-hidden="true">
                <BaseVerticalCard type="normal" v-for="(item, index) in skills" :key="index" :title="item.title" :icon-str="item.skill_icon_title"  />
            </div>
        </div>
        <div class="flex flex-col overflow-hidden space-y-2 h-screen group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused">
                <BaseVerticalCard type="reverse" v-for="(item, index) in skills" :key="index" :title="item.title" :icon-str="item.skill_icon_title"/>
            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused" aria-hidden="true">
                <BaseVerticalCard type="reverse" v-for="(item, index) in skills" :key="index" :title="item.title" :icon-str="item.skill_icon_title"/>
            </div>
        </div>
    </section>
</template>