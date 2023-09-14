<template>
    <div class="w-full flex flex-col items-center justify-center p-4 space-y-4">
        <h1 class="text-3xl" id="skills">Skills</h1>
        <section class="grid grid-cols-2 md:grid-cols-4 justify-center">
            <div v-for="(item, index) in skillData" :key="index" class="py-8 px-10 m-2 rounded-xl flex flex-col items-center space-y-8 bg-light-turquoise shadow-lg dark:bg-primary-dark dark:border dark:border-turquoise">
                <Icon :name="item.icon" size="80"/>
                <p class="">{{ item.name }}</p>
            </div>
        </section>
    </div>
</template>