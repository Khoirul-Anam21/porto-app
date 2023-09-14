
<script setup lang="ts">

const openSocmedPage = (url: string) => {
    window.open(url, '_blank');
}

</script>
<template>
    <div class="w-full flex flex-col md:flex-row space-y-4 items-start justify-around text-primary-light dark:text-primary-dark">
        <section class="space-y-4">
            <h3 class="text-2xl font-bold">Mohammad Khoirul <span class="">Anam</span></h3>
            <div class="text-sm text-white dark:text-primary-dark text-opacity-70">
                <p>Bachelor of Information System and Diploma in English</p>
                <p>Jalan Bunga Kumis Kucing No.21, Lowokwaru, Malang</p>
            </div>
            <p class="italic text-sm text-white dark:text-primary-dark text-opacity-70">khairulanamstud@gmail.com</p>
        </section>
        <section class="flex flex-col">
            <h4 class="text-xl font-bold">Other Me</h4>
            <p class="text-white dark:text-primary-dark text-opacity-70">Hobby in reading Manhwa, watching Youtube, and
                reciting Qur'an</p>
        </section>
        <section class="flex flex-col">
            <h4 class="text-xl font-bold">Reach me out</h4>
            <div class="flex space-x-2">
                <button v-for="(item, index) in socmedData" :key="index" @click="openSocmedPage(item.link)">
                    <Icon  :name="item.icon" size="24"
                        class="cursor-pointer text-white dark:text-primary-dark text-opacity-70" />

                </button>
            </div>
        </section>
</div></template>