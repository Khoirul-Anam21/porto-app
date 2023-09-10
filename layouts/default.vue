<template>
    <div>
        <header class="bg-slate-300 w-full p-4 sticky top-0">
            <nav class="flex justify-between">
                <div>
                    Logo
                </div>
                <div>
                    <ul class="flex space-x-5">
                        <li>About Me</li>
                        <li>Skills</li>
                        <li>Projects</li>
                        <li>Experiences</li>
                        <li>Backgrounds</li>
                    </ul>
                </div>
                <div>
                    Contact me
                </div>
            </nav>
        </header>
        <div class="fixed w-full z-10 top-1/3 right-0 flex items-center justify-between">
            <div class="w-24 h-24 rounded-full -translate-x-1/2 flex items-center justify-end bg-light-turquoise shadow-lg">
                <font-awesome-icon :icon="['fas', 'sun']" size="xl" class="p-4 text-dark-turquoise " />
            </div>
            <div class="flex flex-col">
                <button class="p-2 border border-slate-900">A</button>
                <button class="p-2 border border-slate-900">B</button>
                <button class="p-2 border border-slate-900">C</button>
                <button class="p-2 border border-slate-900">D</button>
            </div>
        </div>
        <slot></slot>
    </div>
</template>

<script setup lang="ts">
</script>