<script setup lang="ts">
import { type Project, type ProjectType } from '../../stores/model-store';
import { onMounted } from 'vue';

const props = defineProps<{
    projects: Project[]
    projectTypes: ProjectType[]
}>()

const tabIndex = ref<number | null>(null);

const allCategoryForNav = {
    key: 0,
    title: "All",
}

const dataNav = computed(() => props.projectTypes.map((projectType: ProjectType) => ({
    key: projectType.id,
    title: projectType.title,
})))

const projectData = computed(() => {
    if (tabIndex.value === null) {
        return []
    }
    if (tabIndex.value === 0) {
        return props.projects;
    }

    return props.projects.filter((project: Project) => project.project_type === tabIndex.value)
})

const getIconFromProjectType = (typeId: number) => {
    return props.projectTypes.filter((projectType: ProjectType) => projectType.id === typeId)[0].icon;
}

const updateOption = (key: number) => {
    tabIndex.value = key
}

onMounted(() => {

})

</script>

<template>
    <section>
        <span class="text-[8pt] md:hidden" >Swipe >></span>
        <BaseOption :data="[allCategoryForNav, ...dataNav]" class="mb-4" @update-current-option="updateOption" />
        <BaseAccordion>
            <BaseAccordionItem v-for="(item, index) in projectData" :key="index" :item-id="index" class="bg-yellow-100">
                <template #header>
                    <section class="flex gap-4 items-start px-2">
                        <div class=" w-[60px] py-1">
                            <NuxtImg
                                :src="`https://admin.anam6.my.id/assets/${getIconFromProjectType(item.project_type)}`" />
                        </div>
                        <div class="py-1 sm:py-2 text-start">
                            <h5 class="font-bold sm:text-lg md:font-normal md:text-2xl">{{ item.title }}</h5>
                            <p class="text-sm sm:text-base" >{{item.short_desc}}</p>
                        </div>
                    </section>
                </template>
                <template #default>
                    <div v-html="item.detail">
                        
                    </div>
                </template>
            </BaseAccordionItem>
        </BaseAccordion>
    </section>
</template>