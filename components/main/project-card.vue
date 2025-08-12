<script setup lang="ts">
import { skillData } from '#imports';


const props = defineProps<{
  project: ProjectInterface
}>()

const techStacksIcons = computed(() => {
  const iconizeStacks = props.project.techstacks.map((val, index) => {
    // console.log(skillData.value);
    const skill = skillData.value.filter((skillVal) => skillVal.name === val)[0];
    console.log(skill);
    return ''
  });
  return iconizeStacks;
})

const openLink = (url: string) => {
  window.open(url, '_blank')
}


</script>

<template>
  <div
    class="p-4 bg-light-turquoise dark:bg-primary-dark dark:border-2 dark:border-turquoise space-y-4 w-[360px] rounded-xl">
    <NuxtImg :src="project.thumbnail" alt="Project Thumbnail" class="w-[300px] cursor-pointer" />
    <div class="">
      <h3 class="text-2xl font-bold hover:underline cursor-pointer" @click="openLink(project.link)">{{ project.title }}</h3>
      <p class="whitespace-pre-wrap">{{ project.description }}</p>
      <div class="relative">
        <div class="flex">
          <button><a :href="project.repo" target="_blank"
              class="absolute z-10 bottom-0 right-0 p-2 rounded-full shadow-lg text-dark-turquoise dark:text-turquoise">
              <Icon name="mdi:github" size="24" />
            </a></button>
        </div>
        <div class="space-x-2">
          <Icon v-for="(item, index) in techStacksIcons" :key="index" :name="item" />
        </div>
      </div>
    </div>
  </div>
</template>