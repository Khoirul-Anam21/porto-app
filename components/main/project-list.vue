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
    name: "All",
}

const dataNav = computed(() => props.projectTypes.map((projectType: ProjectType) => ({
    key: projectType.id,
    name: projectType.name,
})))

const projectData = computed(() => {
    if (tabIndex.value === null) {
        return []
    }
    if (tabIndex.value === 0) {
        return props.projects;
    }

    return props.projects.filter((project: Project) => project.type === tabIndex.value)
})

const getIconFromProjectType = (typeId: number) => {
    return props.projectTypes.filter((projectType: ProjectType) => projectType.id === typeId)[0].icon;
}

const updateOption = (key: number) => {
    tabIndex.value = key
}

onMounted(() => {

})

const config = useRuntimeConfig()

</script>

<template>
    <section>
        <span class="text-[8pt] md:hidden" >Swipe >></span>
        <BaseOption :data="[allCategoryForNav, ...dataNav]" class="mb-4" @update-current-option="updateOption" />
        <BaseAccordion>
            <BaseAccordionItem v-for="(item, index) in projectData"  data-aos="fade-left" data-aos-duration="500"  :data-aos-delay="index * 200" :key="index" :item-id="index" class="bg-yellow-100">
                <template #header>
                    <section class="flex gap-4 items-start px-2 bread sticky">
                        <div class=" w-[60px] py-1">
                            <NuxtImg
                                :src="`${config.public.apiBase}/assets/${getIconFromProjectType(item.type)}`" />
                        </div>
                        <div class="py-1 sm:py-2 text-start">
                            <h5 class="font-bold sm:text-lg md:font-normal md:text-2xl">{{ item.title }}</h5>
                            <p class="text-sm sm:text-base" >{{item.short_desc}}</p>
                        </div>
                    </section>
                </template>
                <template #default>
                    <div v-html="item.detail" class="prose prose-slate prose-sm sm:prose-base md:prose-lg dark:prose-invert prose-li:my-0 prose-p:my-0 prose-img:rounded-lg  prose-img:w-[70%] prose-h1:text-slate-700 prose-h1:text-3xl prose-h2:text-2xl prose-h3:text-xl">
                    </div>
                </template>
            </BaseAccordionItem>
        </BaseAccordion>
    </section>
</template>