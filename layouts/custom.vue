<template>
    <div class="relative container-bg w-full h-max flex flex-col md:flex-row-reverse px-12 sm:px-24">
        <div class="w-full flex flex-col justify-start gap-5">
                <slot></slot>
        </div>
    </div>
</template>

<style scoped>

.container-bg {
    background-color: yellow;
    background-image: radial-gradient(#7D7D7D 1px, #fbfbfb 1px);
    background-size: 30px 30px;
    width: 100%;
    height: max-content;
}
</style>