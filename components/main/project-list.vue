<script setup lang="ts">
import { type Project, type ProjectType } from '../../stores/model-store';
import { onMounted } from 'vue';

const props = defineProps<{
    projects: Project[] | null
    projectTypes: ProjectType[] | null
}>();

const imagesRef = ref<string[]>([]);
const imagesIndexRef = ref<number | null>(null);
const visibleRef = ref(false);
const onHide = () => {
    visibleRef.value = false
    document.body.classList.remove('no-scroll')
};

const tabIndex = ref<number | null>(null);

const allCategoryForNav = {
    key: 0,
    name: "All",
}

const dataNav = computed(() => props.projectTypes?.map((projectType: ProjectType) => ({
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

    return props.projects?.filter((project: Project) => project.type === tabIndex.value)
})

const getIconFromProjectType = (typeId: number) => {
    return props.projectTypes?.filter((projectType: ProjectType) => projectType.id === typeId)[0].icon_img;
}

const updateOption = (key: number) => {
    tabIndex.value = key
}


const selectImages = (images: string[], index: number) => {
    imagesRef.value = images;
    imagesIndexRef.value = index;
    visibleRef.value = true;
    document.body.classList.add('no-scroll')
}

// const showImg = (index: number) => {
//     imagesIndexRef.value = index;
//     visibleRef.value = true;
// };


onMounted(() => {

})

const config = useRuntimeConfig()

</script>

<template>
    <section class="px-1 py-4">
        <span class="text-[8pt] md:hidden">Swipe >></span>
        <BaseOption :data="[allCategoryForNav, ...dataNav]" class="mb-4 projects-filters" @update-current-option="updateOption" />
        <BaseAccordion>
            <BaseAccordionItem v-for="(item, index) in projectData"
                :key="index" :item-id="index" class="paper-card paper-card-raised project-accordion-item">
                <template #header>
                    <section class="flex gap-2 sm:gap-4 items-start px-2 bread sticky min-w-0 flex-1">
                        <div class="max-w-[32px] sm:max-w-[40px] py-1 shrink-0">
                            <NuxtImg :src="`${getIconFromProjectType(item.type)}`" />
                        </div>
                        <div class="py-1 sm:py-2 text-start min-w-0 flex-1">
                            <h5 class="font-bold text-sm sm:text-lg md:font-normal md:text-2xl break-words">{{ item.title }}</h5>
                        </div>
                    </section>
                </template>
                <template #default>
                    <div>
                        <ProjectCarousel v-if="item.images.length > 0" :images="item.images"
                            @update:images="selectImages" />
                        <p class="text-sm sm:text-base mb-2">{{ item.description }}</p>
                        <p v-if="item.skills_used.length > 0" class="mb-2">Tech Stacks: </p>
                        <div v-if="item.skills_used.length > 0" class="flex flex-wrap gap-2 mb-2">
                            <div v-for="(skill, idx) in item.skills_used" :key="idx">
                                <div
                                    class="flex items-center gap-2 px-4 py-1 bg-leaf-light/30 text-leaf-dark rounded-full text-sm sm:text-base">
                                </div>
                            </div>
                        </div>
                        <hr v-if="item.detail" />
                        <div v-html="item.detail"
                            class="prose prose-neutral prose-sm sm:prose-base md:prose-lg dark:prose-invert prose-li:my-0 prose-p:text-bark prose-p:text-base prose-li:text-sm prose-img:rounded-lg prose-img:w-[70%] prose-h1:text-bark prose-h1:text-3xl prose-h2:text-bark prose-h2:text-2xl prose-h3:text-bark prose-h3:text-xl overflow-hidden">
                        </div>
                    </div>


                </template>
            </BaseAccordionItem>
        </BaseAccordion>
        <VueEasyLightbox v-if="imagesRef.length > 0" class="absolute" :visible="visibleRef" :imgs="imagesRef"
            :index="imagesIndexRef" @hide="onHide" />
    </section>
</template>


<style scoped>
body.no-scroll {
    overflow: hidden;
    touch-action: none;
    /* prevent touch scrolling */
}
</style>