<script setup lang="ts">
import { useStateStore } from '@/stores/index'

const stateStore = useStateStore()

const goTo = (reference: string) => {
    const element = document.getElementById(reference);
    if (element) {
        element.scrollIntoView({ behavior: 'smooth' });
    }
}

const openCV = () => {
    window.open('https://docs.google.com/document/d/1B09vjlvs6BRPIiXFsgUlOEos6JMNCoZjHxe3PVf8WVA/edit', '_blank')
}


</script>

<template>
    <div class="w-full flex flex-col md:flex-row-reverse px-6 sm:px-24 py-8 sm:py-28     h-full">
        <div class="bg-slate-50 w-full flex flex-col h-full justify-start">
            <MainNavList />
            <section class="flex-grow border-4 border-black border-opacity-85 rounded-2xl p-4">hai</section>
        </div>
        <article class=" w-full basis-1/5 md:basis-1/3 px-5 ">
            <div class=" w-full h-full rounded-xl flex flex-col items-center border-4 border-black border-opacity-85">
                <div class="-translate-y-1/4 ">
                    <NuxtImg class="rounded-full w-[200px] h-[200px] object-cover "
                        src="https://res.cloudinary.com/dcmya61ry/image/upload/f_auto,q_auto/cld-sample"
                        alt="Profile Image"></NuxtImg>
                </div>
                <section class="-translate-y-8 flex flex-col h-full items-center">
                    <h1 class="text-3xl">Moh. Khoirul Anam</h1>
                    <p class="text-lg text-slate-700">Calon Direktur</p>
                    <div class="flex flex-row py-2">
                        <a href="/">
                            <NuxtImg src="images/icons/icons8-email-48.png" class="scale-75" />
                        </a>
                        <a href="/">
                            <NuxtImg src="images/icons/icons8-linkedin-48.png" class="scale-75" />
                        </a>
                        <a href="/">
                            <NuxtImg src="images/icons/icons8-instagram-48.png" class="scale-75" />
                        </a>
                        <a href="/">
                            <NuxtImg src="images/icons/icons8-github-48.png" class="scale-75" />
                        </a>
                    </div>
                    <div class="w-full bg-slate-50 h-full flex-grow rounded-2xl p-4">
                        <h1>tes</h1>
                    </div>
                </section>

            </div>
        </article>
    </div>
</template>