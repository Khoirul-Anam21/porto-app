<script setup lang="ts">



</script>
<template>
    <div class="w-full flex flex-row h-[200px] gap-8 px-4 pt-2" >
        <div class="flex flex-col h-full  items-center justify-between relative">
            <div class="w-10 h-10 bg-black relative mt-1">
                <div class="w-10 h-10 bg-purple-400 border border-black -translate-x-1 -translate-y-1"></div>
            </div>
            <div class="my-1 timeline-custom-line">
            </div>
        </div>
        <div class="flex-grow  pb-6">
            <div class="w-full h-full bg-pink-50 rounded-2xl border-2 border-black">
                <slot></slot>
            </div>
        </div>
    </div>
</template>

<style scoped>

.timeline-custom-line {
    height: 100%;
    width: 4px;
    background-image: url("data:image/svg+xml,%3csvg width='100%25' height='100%25' xmlns='http://www.w3.org/2000/svg'%3e%3crect width='100%25' height='100%25' fill='none' stroke='black' stroke-width='10' stroke-dasharray='7%2c 14%2c 9' stroke-dashoffset='0' stroke-linecap='butt'/%3e%3c/svg%3e");
    /* background-position: top;
    background-size: 10px 1px;
    background-repeat: repeat-x;
    border-color: red;
    border-width: 2px;
    border-style: dashed; */
}

</style>