<script setup lang="ts">


const getIconinSkills = (skill: string) => {
    const skills = skillData;
    const iconData = skills.value.find(val => val.name === skill);
    return iconData?.icon ?? "";
}
</script>

<template>
    <!-- Card Blog -->
    <div class="max-w-[85rem] px-4 py-10 sm:px-6 lg:px-8 lg:py-14 mx-auto">
        <!-- Title -->
        <div class="max-w-2xl mx-auto text-center mb-10 lg:mb-14">
            <h2 class="text-2xl font-bold md:text-4xl md:leading-tight dark:text-white">The Blog</h2>
            <p class="mt-1 text-gray-600 dark:text-gray-400">See how game-changing companies are making the most of every
                engagement with Preline.</p>
        </div>
        <!-- End Title -->

        <!-- Grid -->
        <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Card -->
            <a v-for="(item, index) in projectData" :key="index" :project="item"
                class="group flex flex-col h-full border border-gray-200 hover:border-transparent hover:shadow-lg transition-all duration-300 rounded-xl p-5 dark:border-gray-700 dark:hover:border-transparent dark:hover:shadow-black/[.4] dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                href="/project/tes">
                <div class="aspect-w-16 aspect-h-11">
                    <img class="w-full object-cover rounded-xl" :src="item.thumbnail" alt="Image Description">
                </div>
                <div class="my-6">
                    <h3 class="text-xl font-semibold text-gray-800 dark:text-gray-300 dark:group-hover:text-white">
                        {{ item.title }}
                    </h3>
                    <p class="mt-5 text-gray-600 dark:text-gray-400">
                        {{ item.description }}
                    </p>
                </div>
                <div class="mt-auto flex items-center gap-x-3">
                    <Icon v-for="(icon, index) in item.techstacks" :key="index" :name="getIconinSkills(icon)" size="24" />
                    <a class="py-3 px-4 inline-flex items-center gap-x-1 text-sm font-medium rounded-full   text-blue-600 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-transparent dark:text-blue-300 dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                        href="/project/tes">
                        Read more
                        <svg class="flex-shrink-0 w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                            stroke-linejoin="round">
                            <path d="m9 18 6-6-6-6" />
                        </svg>
                    </a>
                </div>
            </a>
            <!-- End Card -->

            <!-- End Card -->
        </div>
        <!-- End Grid -->

        <!-- Card -->
        <div class="mt-12 text-center">
            <a class="py-3 px-4 inline-flex items-center gap-x-1 text-sm font-medium rounded-full border border-gray-200 bg-white text-blue-600 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700 dark:text-blue-500 dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                href="#">
            Read more
            <svg class="flex-shrink-0 w-4 h-4" xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                stroke-linejoin="round">
                <path d="m9 18 6-6-6-6" />
            </svg>
        </a>
    </div>
    <!-- End Card -->
</div>
<!-- End Card Blog --></template>