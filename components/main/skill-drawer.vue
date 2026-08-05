<script setup lang="ts">
import { type Skill } from '~/stores/model-store'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

const props = defineProps<{
    skills: Skill[]
}>()

const emit = defineEmits<{
    toggle: [isOpen: boolean]
}>()

const isOpen = ref(true)
const { width } = useWindowSize()
const isMobile = computed(() => width.value < 768)

const drawerWidth = computed(() => isMobile.value ? '78vw' : '140px')

const toggle = () => {
    isOpen.value = !isOpen.value
    emit('toggle', isOpen.value)
}

const close = () => {
    isOpen.value = false
    emit('toggle', false)
}

watch(isOpen, () => {
    nextTick(() => {
        setTimeout(() => ScrollTrigger.refresh(), 450)
    })
})

onMounted(() => {
    // On mobile, start closed so content is visible
    if (isMobile.value) {
        isOpen.value = false
        emit('toggle', false)
    } else {
        emit('toggle', true)
    }
})
</script>

<template>
    <!-- Mobile backdrop -->
    <Transition name="backdrop">
        <div v-if="isOpen && isMobile" class="fixed inset-0 bg-black/30 z-30 md:hidden" @click="close" />
    </Transition>

    <!-- Toggle button -->
    <button @click="toggle" class="absolute top-[15%] -translate-y-1/2 z-40
               flex items-center justify-center
               w-7 h-fit rounded-l-lg py-4 px-2
               bg-paper border border-paper-edge border-r-0
               shadow-paper cursor-pointer
               transition-[right] duration-[400ms] ease-[cubic-bezier(0.4,0,0.2,1)]
               hover:bg-paper-dark"
        :style="isOpen ? { right: isMobile ? drawerWidth : '140px' } : { right: '0' }"
        :title="isOpen ? 'Hide skills' : 'Show skills'">
        <section class="flex flex-col items-center gap-1">
            <Icon name="material-symbols:chevron-right-rounded" size="20"
                class="text-bark transition-transform duration-300" :class="{ 'rotate-180': isOpen }" />
            <span class="text-[12px] font-bold text-bark-light uppercase tracking-wider"
                style="writing-mode: vertical-rl; transform: rotate(180deg);">
                {{ isOpen ? 'Hide' : 'Discover Skills' }}
            </span>
        </section>
    </button>

    <!-- Drawer panel -->
    <aside class="absolute top-0 right-0 h-full z-40
               md:w-[140px]
               bg-paper border-l border-paper-edge
               shadow-paper-lg
               transform-gpu transition-transform duration-[400ms] ease-[cubic-bezier(0.4,0,0.2,1)]"
        :class="isOpen ? 'translate-x-0' : 'translate-x-full'"
        :style="isMobile ? { width: drawerWidth, maxWidth: '320px' } : {}">
        <div class="flex flex-col h-full overflow-hidden">
            <!-- Header -->
            <div class="flex items-center px-2 pt-8 pb-3 shrink-0">
                <h2 class="text-sm text-bark font-semibold whitespace-nowrap">
                    My Skills
                </h2>
                <div class="flex items-center">
                    <BaseRoundDecor class="border-4 border-paper scale-[60%] my-1" />
                    <div class="w-8 h-[2px] bg-paper-edge rounded-full"></div>
                </div>
            </div>

            <!-- Skills content -->
            <div class="flex-1 overflow-hidden px-2 pb-6">
                <MainSkillsets :skills="skills" />
            </div>
        </div>
    </aside>
</template>

<style scoped>
.backdrop-enter-active,
.backdrop-leave-active {
    transition: opacity 0.3s ease;
}

.backdrop-enter-from,
.backdrop-leave-to {
    opacity: 0;
}
</style>
