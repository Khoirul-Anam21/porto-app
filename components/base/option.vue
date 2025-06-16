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
    <div class="wrapper scroll-container overflow-hidden relative whitespace-nowrap no-scrollbar">
        <div v-for="(item, index) in props.data" :key="index" class="option ">
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
    --font-color-dark: #323232;
    --font-color-light: #FFF;
    --bg-color: #fff;
    --main-color: #323232;
    position: relative;
    width: 100%;
    height: 36px;
    background-color: var(--bg-color);
    border: 2px solid var(--main-color);
    border-radius: 34px;
    display: flex;
    flex-direction: row;
    box-shadow: 4px 4px var(--main-color);
}

.option {
    width: max-content;
    height: 28px;
    position: relative;
    top: 2px;
    left: 2px;
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
}

.input:checked+.btn {
    background-color: var(--main-color);
}

.input:checked+.btn .span {
    color: var(--font-color-light);
}
</style>