<template>
    <section class="inline-flex gap-8">
        <div class="flex flex-col overflow-hidden space-y-2 h-screen group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused">
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />

            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused" aria-hidden="true">
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />
                <MainBaseVerticalCard type="normal" />

            </div>
        </div>
        <div class="flex flex-col overflow-hidden space-y-2 h-screen group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused">
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused" aria-hidden="true">
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
                <MainBaseVerticalCard type="reverse" />
            </div>
        </div>
    </section>
</template>