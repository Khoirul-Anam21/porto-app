<script setup lang="ts">

const { system, store } = useColorMode()

watch(system, (newv, old) => {
  console.log(newv);
});

// const mode = computed(() => store.value === 'auto' ? system.value : store.value)

// const layout = 'blank';
</script>



<template>
    <div class="scroll-smooth">
      <NuxtLayout>
        <NuxtPage />  
      </NuxtLayout>
    </div>
</template>


