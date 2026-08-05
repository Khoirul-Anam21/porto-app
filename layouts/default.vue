<script setup lang="ts">
import { useStateStore } from '@/stores/index';
import { ref, onMounted, onBeforeUnmount } from 'vue';
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
const profileSheetHeight = ref(0);
let measureScheduled = false;
let measuring = false;

const measureHeight = () => {
    if (measureScheduled || measuring) return;
    measureScheduled = true;
    requestAnimationFrame(() => {
        measureScheduled = false;
        if (!profileSheetRef.value) return;
        measuring = true;
        // Temporarily remove height to read natural content height
        const el = profileSheetRef.value;
        const prevHeight = el.style.height;
        const prevTransition = el.style.transition;
        el.style.transition = 'none';
        el.style.height = 'auto';
        // Force reflow
        void el.offsetHeight;
        const naturalHeight = el.scrollHeight;
        el.style.height = prevHeight;
        el.style.transition = prevTransition;
        // Force reflow again so the transition re-engages for the next change
        void el.offsetHeight;
        profileSheetHeight.value = naturalHeight + 16;
        measuring = false;
    });
}

const openProfileSheet = () => {
    if (width.value < 768) {
        profileSheetOpen.value = !profileSheetOpen.value;
        nextTick(measureHeight);
    }
    return;
}

// Measure only on user actions and viewport changes — never on auto-render
watch(() => width.value, () => {
    nextTick(measureHeight);
});

watch(profileSheetOpen, () => {
    nextTick(measureHeight);
});

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
    measureHeight();
    setTimeout(measureHeight, 300);
});

onBeforeUnmount(() => {
    // no-op
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
        <div class="relative paper-bg w-full h-max flex flex-col md:flex-row-reverse px-5 sm:px-24 py-6 sm:py-14 overflow-x-hidden">
            <div class="w-full min-w-0 flex flex-col justify-start gap-5"
                :style="{ margin: `0 0 ${width < 768 ? profileSheetHeight : 0}px 0` }">
                <section class="sticky top-0 md:top-16 z-50">
                    <MainNavList />
                </section>
                <section class="flex-grow paper-card paper-card-raised paper-edge p-4 sm:p-6 overflow-hidden">
                    <slot></slot>
                </section>
                <footer
                    class="paper-card p-4 flex items-center justify-center w-full transition-all duration-200">
                    <p class="text-xs md:text-sm italic text-bark-light">"Today is a Gift, That's Why It's Called the
                        Present"</p>
                </footer>
            </div>

            <!-- Profile -->
            <section class="relative md:sticky top-16 w-full h-full md:basis-1/3 md:px-5 z-50">
                <div class="fixed md:static bottom-0 left-0 w-full flex justify-center pointer-events-none">
                    <div ref="profileSheetRef" :style="{ height: `${profileSheetHeight}px` }"
                        class="profile-card w-[92vw] max-w-[420px] paper-card paper-card-raised md:w-full md:max-w-none relative rounded-xl flex flex-col items-center px-4 sm:px-6 md:px-8 pt-0 transform-gpu transition-all ease-out duration-[600ms] pointer-events-auto overflow-hidden md:overflow-visible">
                        <div class="md:hidden w-full flex justify-center -mt-2 pt-1 cursor-pointer"
                            @click="openProfileSheet">
                            <div class="w-10 h-1.5 rounded-full bg-paper-edge"></div>
                        </div>
                        <div class="absolute right-3 top-3 px-2 py-2 bg-paper-dark rounded-full cursor-pointer z-10 md:hidden"
                            @click="openProfileSheet">
                            <Icon name="mage:chevron-down" :class="{ 'rotate-180': profileSheetOpen }" size="1.25em"
                                class="transform-gpu transition-all duration-500" />
                        </div>
                        <!-- Mobile collapsed header -->
                        <div class="md:hidden flex flex-row items-center gap-3 w-full pt-1 pb-3">
                            <NuxtImg class="rounded-full w-12 h-12 object-cover border-2 border-paper-edge shrink-0" format="webp"
                                src="https://res.cloudinary.com/dj8gvk6wr/image/upload/v1753718118/IMG_20250728_211241_oofgyx.jpg"
                                alt="Profile Image"></NuxtImg>
                            <div class="flex-1 min-w-0">
                                <h1 class="text-base font-semibold leading-tight break-words">{{ stateStore.name }}</h1>
                                <p v-show="profileSheetOpen || width > 768"
                                    class="text-xs text-bark-light break-words leading-tight mt-0.5">- {{ stateStore.jobPosition }} -</p>
                            </div>
                        </div>

                        <!-- Desktop image -->
                        <div class="hidden md:flex -translate-y-1/4 flex-row justify-center w-full items-end">
                            <NuxtImg class="rounded-full w-[200px] h-[200px] object-cover" format="webp"
                                src="https://res.cloudinary.com/dj8gvk6wr/image/upload/v1753718118/IMG_20250728_211241_oofgyx.jpg"
                                alt="Profile Image"></NuxtImg>
                        </div>
                        <!-- Desktop name -->
                        <div class="hidden md:flex flex-col items-center w-full">
                            <h1 class="text-2xl text-center break-words px-2">{{ stateStore.name }}</h1>
                            <p v-show="profileSheetOpen || width > 768"
                                class="text-base text-bark-light text-center w-full break-words px-2">- {{ stateStore.jobPosition }} -</p>
                        </div>

                        <!-- Expanded content -->
                        <div v-show="profileSheetOpen || width > 768"
                            class="md:flex md:flex-col w-full md:items-center md:-translate-y-8">
                            <!-- Mobile social icons -->
                            <div class="flex md:hidden flex-row justify-center gap-4 py-3 border-b border-paper-edge w-full">
                                <a :href="stateStore.whatsapp_url" class="w-7">
                                    <NuxtImg src="images/icons/icons8-whatsapp-48.png" />
                                </a>
                                <a :href="stateStore.linkedin_url" class="w-7">
                                    <NuxtImg src="images/icons/icons8-linkedin-48.png" />
                                </a>
                                <a :href="stateStore.email_url" class="w-7">
                                    <NuxtImg src="images/icons/icons8-email-48.png" />
                                </a>
                                <a :href="stateStore.github_url" class="w-7">
                                    <NuxtImg src="images/icons/icons8-github-48.png" />
                                </a>
                            </div>

                            <!-- Desktop social icons -->
                            <div class="hidden md:flex flex-row py-2 gap-3">
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

                            <!-- Info panel -->
                            <div class="w-full bg-paper-dark rounded-2xl p-4 mt-2">
                                <div class="flex gap-3 items-center">
                                    <Icon class="shrink-0" name="ph:hand-heart-light" size="24px" />
                                    <p class="text-sm text-bark-light truncate">{{ age + ' y.o' }}</p>
                                </div>
                                <div class="flex gap-3 items-center mt-3">
                                    <Icon class="shrink-0" name="system-uicons:location" size="24px" />
                                    <p class="text-sm text-bark-light truncate">{{ stateStore.address }}</p>
                                </div>
                                <div class="flex gap-3 items-center mt-3">
                                    <Icon class="shrink-0" name="fluent:games-20-regular" size="24px" />
                                    <p class="text-sm text-bark-light truncate">{{ stateStore.hobby }}</p>
                                </div>
                            </div>

                            <div class="flex justify-center md:block w-full">
                                <BaseSmoothBtn @clicked="downloadCV" class="mt-4">Download CV</BaseSmoothBtn>
                            </div>
                        </div>
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

.paper-bg {
    background-color: #F8F4EC;
    background-image: 
        radial-gradient(circle at 20% 80%, rgba(107, 143, 60, 0.05) 0%, transparent 50%),
        radial-gradient(circle at 80% 20%, rgba(135, 206, 235, 0.05) 0%, transparent 50%),
        url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23d4c9b8' fill-opacity='0.15'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
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