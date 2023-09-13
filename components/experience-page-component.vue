<template>
    <div>
        <h1 class="pt-4 text-4xl ">Experiences</h1>
        <div class="flex space-x-2 pb-8 pt-1 px-1">
            <div v-for="(item, index) in 'abc'" :key="index" class="h-2 w-2 rounded-full bg-turquoise "></div>
        </div>
        <div class="timeline-root">
            <div class="timeline-body">
                <div class="timeline-point">
                    <div alt="" class="mx-auto h-12 w-12 rounded-full bg-turquoise" ></div>
                </div>
                <div class="timeline-content">
                    <div>
                        <h4 class="text-base font-bold">Backend Developer</h4>
                        <p class="text-sm font-light">Feb 2023 - Aug 2023</p>
                    </div>
                    <div class="flex items-center gap-2">
                        <p class="inline-block text-lg">
                           IT Internship at PointHub
                        </p>
                    </div>
                    <p class="font-light -mt-2 text-primary-dark dark:text-white dark:text-opacity-60">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                        exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    </p>
                </div>
            </div>
            <!-- <div class="timeline-body">
                <div class="timeline-point">
                    <img src="https://via.placeholder.com/150" alt="" class="mx-auto h-12 w-12 rounded-full" />
                </div>
                <div class="timeline-content">
                    <div>
                        <h4 class="text-base font-bold">Charles</h4>
                        <p class="text-sm font-light">20 sec</p>
                    </div>
                    <div class="flex items-center gap-2">
                        <p class="inline-block text-lg">
                            <span class="font-bold">CREATE</span> INVOICE0000001
                        </p>
                    </div>
                    <p class="font-light -mt-2">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
                        exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                    </p>
                </div>
            </div> -->
        </div>
    </div>
</template>

<style scoped>
.timeline-root {
    @apply flex flex-col;
}

.timeline-body {
    @apply flex space-x-4 mb-8;
}

.timeline-point {
    @apply relative z-[2] mx-auto before:absolute before:left-1/2 before:top-12 before:hidden before:h-auto before:w-0 before:border-l-2 before:border-slate-200 before:-bottom-8 before:-z-[1] sm:before:block before:-translate-x-1/2 dark:before:border-slate-600;
}

.timeline-content {
    @apply flex flex-col flex-1 gap-4;
}
</style>
