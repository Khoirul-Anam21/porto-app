<script setup lang="ts">



const props = defineProps<{
    data: {
        key: number
        name: string
    }[]
}>()

const emit = defineEmits(['updateCurrentOption'])

onMounted(() => {
    emit('updateCurrentOption', props.data[0].key);
})

</script>

<template>
    <div class="wrapper scroll-container relative whitespace-nowrap no-scrollbar">
        <div v-for="(item, index) in props.data"  data-aos="fade-left" data-aos-duration="500" :data-aos-delay="index * 100" :key="index" class="option ">
            <input :key="index" class="input" type="radio" name="btn" :value="item"
                @change="() => emit('updateCurrentOption', item.key)" :checked="index === 0">
            <div class="btn">
                <span class="span px-4">{{ item.name }}</span>
            </div>
        </div>
        <!-- <div>
            <input class="input" type="radio" name="btn"  @change="() => emit('updateCurrentOption', 0)" >
            <div class="btn" >
                <span class="span px-4">{{ item.title }}</span>
            </div>
        </div> -->
    </div>

</template>

<style scoped>
.scroll-container {
    overflow-x: auto;
    overflow-y: hidden;
    white-space: nowrap;
    cursor: grab;
    user-select: none;
    -webkit-overflow-scrolling: touch;
}

.grid-wrapper {
    display: flex;
    /* Allow items to flow horizontally */
    touch-action: pan-left pan-right;
    /* Allow drag for touchscreens */
}

.no-scrollbar::-webkit-scrollbar {
    display: none;
}

.no-scrollbar {
    -ms-overflow-style: none;
    /* IE and Edge */
    scrollbar-width: none;
    /* Firefox */
}

.wrapper {
    --font-color-dark: #5C4033;
    --font-color-light: #FFF;
    --bg-color: #F8F4EC;
    --main-color: #6B8F3C;
    position: relative;
    width: 100%;
    height: 36px;
    background-color: var(--bg-color);
    border: 1px solid #D4C9B8;
    border-radius: 34px;
    display: flex;
    flex-direction: row;
    box-shadow: 0 1px 3px rgba(0,0,0,0.08);
}

.option {
    width: max-content;
    height: 28px;
    position: relative;
    top: 2px;
    left: 2px;
    flex-shrink: 0;
}

.input {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
    appearance: none;
    cursor: pointer;
}

.btn {
    width: 100%;
    height: 100%;
    background-color: var(--bg-color);
    border-radius: 50px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.span {
    color: var(--font-color-dark);
    font-size: 11px;
    white-space: nowrap;
}

@media (min-width: 640px) {
    .span {
        font-size: 14px;
    }
}

.input:checked+.btn {
    background-color: var(--main-color);
}

.input:checked+.btn .span {
    color: var(--font-color-light);
}
</style>