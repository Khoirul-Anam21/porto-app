<script setup lang="ts">
import { type Project, type ProjectType } from '../../stores/model-store';

const props = defineProps<{
    projects: Project[]
    projectTypes: ProjectType[]
}>()

const tabIndex = ref<number | null>(null)

const dataNav = computed(() => props.projectTypes.map((projectType: ProjectType) => ({
    key: projectType.id,
    title: projectType.title,
})))

const projectData = computed(() => tabIndex ? props.projects.filter((project: Project) => project.project_type === tabIndex.value) : [])

const updateOption = (key: number) => {
    tabIndex.value = key
}

</script>

<template>
    <section>
        <BaseOption :data="dataNav" class="my-4" @update-current-option="updateOption" />
        <h1>{{ tabIndex }}</h1>
        <p>{{ projectData }}</p>
    </section>
</template>