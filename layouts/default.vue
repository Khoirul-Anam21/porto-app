<script setup lang="ts">
import { useStateStore } from '@/stores/index';
import { ref, onMounted } from 'vue';
import { useWindowSize } from '@vueuse/core'

const { width } = useWindowSize()

const colorMode = useColorMode();
const stateStore = useStateStore();
const toggleDarkTheme = () => {
    if (colorMode.value === 'light') {
        colorMode.value = 'dark';
        return;
    }
    colorMode.value = 'light';
};

const age = computed(() => {
    const rangeDate = new Date(stateStore.currentDate.valueOf() - stateStore.birthDate.valueOf());
    const ageNum = rangeDate.getUTCFullYear() - 1970
    return ageNum;
})

const isDark = computed(() => colorMode.value === 'dark');

const downloadCV = () => {
    window.open('https://docs.google.com/document/d/1B09vjlvs6BRPIiXFsgUlOEos6JMNCoZjHxe3PVf8WVA/edit?usp=sharing', '_blank');
}

const profileSheetOpen = ref(false);
const profileSheetRef = ref();
let profileSheetHeight = ref();
let initProfileSheetHeight = ref();


const openProfileSheet = () => {
    if (width.value < 768) {
        profileSheetOpen.value = !profileSheetOpen.value;
        nextTick(updateHeight);
    }
    return;
}

const updateHeight = () => {
    if (profileSheetOpen.value) {
        profileSheetHeight.value = profileSheetRef.value.scrollHeight + 30
    } else {
        profileSheetHeight.value = initProfileSheetHeight.value;
    }
}

watch(stateStore.$state, (newV, oldV) => {
    if (!newV.socmedActive) {
        return
    }
    setTimeout(() => {
        if (stateStore.$state.socmedIndex === 5) {
            stateStore.$state.socmedIndex = 0
            return;
        }
        stateStore.$state.socmedIndex++
    }, 1000);
});

onMounted(() => {
    profileSheetHeight.value = profileSheetRef.value.scrollHeight;
    initProfileSheetHeight.value = profileSheetRef.value.scrollHeight;
})


</script>

<template>
    <div>
        <!-- Dark mode toggle -->
        <!-- <div class="fixed w-full z-50 top-1/3 right-0 bg-slate-400">
            <div @click="toggleDarkTheme"
                class="absolute top-1/2 left-0 w-24 h-24 rounded-full -translate-x-1/2 flex items-center justify-center side-btn shadow-lg cursor-pointer">
                <div class="flex justify-between w-full p-3"
                    :class="{ 'animate-rotate fill-mode-forward': isDark, 'animate-rotateback fill-mode-forward': !isDark }">
                    <Icon name="material-symbols:dark-mode-outline"
                        :class="{ 'rotate-180': !isDark, '-rotate-180': isDark }" size="28" />
                    <Icon name="material-symbols:light-mode-outline" size="28" />
                </div>
            </div>
        </div> -->

        <!-- Layout -->
        <div class="relative container-bg w-full h-max flex flex-col md:flex-row-reverse px-5 sm:px-24 py-8 sm:py-28">
            <div class="w-full flex flex-col justify-start gap-5"
                :style="{ margin: `0 0 ${width < 768 ? profileSheetHeight : 0}px 0` }">
                <section class="sticky top-10 z-50">
                    <MainNavList class="" />
                </section>
                <section class="flex-grow border-4 border-black border-opacity-85 rounded-2xl p-4 bg-white">
                    <slot></slot>
                </section>
                <footer
                    class="border-4 border-black p-4 flex items-center justify-center w-full rounded-2xl bg-blue-100 transition-all duration-200">
                    <p class="text-xs md:text-sm italic text-gray-600">“Today is a Gift, That’s Why It’s Called the
                        Present”</p>
                </footer>
            </div>

            <!-- Profile -->
            <section class="relative md:sticky top-16 w-full h-full md:basis-1/3 md:px-5 z-50">
                <div class="fixed md:static bottom-0 left-0 w-full flex justify-center">
                    <div ref="profileSheetRef" :style="{ height: `${profileSheetHeight}px` }"
                        class="w-[85vw] bg-white md:w-full relative rounded-xl flex flex-col items-center border-4 border-black border-opacity-85 px-8 transform-gpu transition-all ease-out duration-[600ms]">
                        <div class="absolute right-4 sm:right-auto px-4 py-2 bg-slate-100 cursor-pointer z-10 md:hidden"
                            @click="openProfileSheet">
                            <Icon name="mage:chevron-down" :class="{ 'rotate-180': profileSheetOpen }" size="1.5em"
                                class="transform-gpu transition-all duration-500" />
                        </div>
                        <div class="-translate-y-1/4 flex flex-row justify-between md:justify-center w-full items-end">
                            <NuxtImg class="rounded-full w-[120px] h-[120px] md:w-[200px] md:h-[200px] object-cover " format="webp"
                                src="https://res.cloudinary.com/dj8gvk6wr/image/upload/v1753718118/IMG_20250728_211241_oofgyx.jpg"
                                alt="Profile Image"></NuxtImg>
                            <div class="flex flex-row pt-4  gap-3 md:hidden">
                                <a :href="stateStore.whatsapp_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-whatsapp-48.png" />
                                </a>
                                <a :href="stateStore.linkedin_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-linkedin-48.png" />
                                </a>
                                <a :href="stateStore.email_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-email-48.png" class="w-12" />
                                </a>
                                <a :href="stateStore.github_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-github-48.png" />
                                </a>
                            </div>
                        </div>
                        <section
                            class="-translate-y-4 md:-translate-y-8 flex flex-col h-full w-full justify-start md:justify-center items-start md:items-center">
                            <div class="flex flex-col items-center md:items-center w-full">
                                <h1 class="text-xl sm:text-2xl text-center">{{ stateStore.name }}</h1>
                                <p v-show="profileSheetOpen || width > 768"
                                    class="text-base md:text-base text-slate-700 text-center sm:text-center w-full">- {{
                                        stateStore.jobPosition
                                    }} -</p>
                            </div>
                            <div class="md:flex flex-row py-2 gap-3 hidden">
                                <a :href="stateStore.whatsapp_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-whatsapp-48.png" />
                                </a>
                                <a :href="stateStore.linkedin_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-linkedin-48.png" />
                                </a>
                                <a :href="stateStore.email_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-email-48.png" />
                                </a>
                                <a :href="stateStore.github_url" class="w-[30px]">
                                    <NuxtImg src="images/icons/icons8-github-48.png" />
                                </a>
                            </div>
                            <div v-show="profileSheetOpen || width > 768"
                                class="w-full bg-slate-50 h-full flex-grow rounded-2xl p-4 mt-2 block">
                                <div class="flex gap-3 items-center">
                                    <Icon class="basis-1/5" name="ph:hand-heart-light" size="28px" />
                                    <p class="text-sm basis-4/5 text-gray-600">{{ age + ' y.o' }}</p>
                                </div>
                                <div class="flex gap-3 items-center mt-3">
                                    <Icon class="basis-1/5" name="system-uicons:location" size="28px" />
                                    <p class="text-sm basis-4/5 text-gray-600">{{ stateStore.address }}</p>
                                </div>
                                <div class="flex gap-3 items-center mt-3">
                                    <Icon class="basis-1/5" name="fluent:games-20-regular" size="30px" />
                                    <p class="text-sm basis-4/5 text-gray-600">{{ stateStore.hobby }}</p>
                                </div>
                            </div>
                            <div v-show="profileSheetOpen || width > 768">
                                <BaseSmoothBtn @clicked="downloadCV" class="mt-4">Download CV</BaseSmoothBtn>
                            </div>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </div>
</template>

<style scoped>
.fill-mode-forward {
    animation-fill-mode: forwards;
}

.container-bg {
    background-color: yellow;
    background-image: radial-gradient(#7D7D7D 1px, #fbfbfb 1px);
    background-size: 30px 30px;
    width: 100%;
    height: max-content;
}

/* .container-bg {
  --bg: radial-gradient(#000 5%, #0000 6%);
  --size: 3rem;
  width: 100%;
  height: 100%;

  pattern here
  background-image: radial-gradient(#000 5%, #0000 6%),
    radial-gradient(#000 5%, #0000 6%);
  background-position: 0 0, calc(var(--size) / 2) calc(var(--size) / 2);
  background-size: var(--size) var(--size);
} */
</style>