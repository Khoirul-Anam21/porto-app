<template>
    <section class="inline-flex gap-3">
        <!-- <div class="w-max flex justify-center items-center">
            <div class="w-max bg-red-100 gap-2 animate-loop-scroll flex">
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
            </div>
            <div class="w-max bg-red-100 gap-2 animate-loop-scroll flex" aria-hidden="true">
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
                <div class="w-8 h-8 bg-slate-400"></div>
            </div>
        </div> -->
        <div class="flex flex-col overflow-hidden space-y-2 h-[500px] group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused">
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>

            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-up group-hover:paused" aria-hidden="true">
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>
                <MainBaseVerticalCard type="normal"/>

            </div>
        </div>
        <div class="flex flex-col overflow-hidden space-y-2 h-[500px] group">
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused">
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
            </div>
            <div class="flex flex-col w-min gap-2 animate-loop-scroll-down group-hover:paused" aria-hidden="true">
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
                <MainBaseVerticalCard type="reverse"/>
            </div>
        </div>
    </section>
</template>
