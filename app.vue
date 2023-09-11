<script setup lang="ts">

const { system, store } = useColorMode()

watch(system, (newv, old) => {
  console.log(newv);
});

const mode = computed(() => store.value === 'auto' ? system.value : store.value)


</script>


<template>
  <div class="bg-primary-light dark:bg-primary-dark">
    <NuxtLayout>
      <h1 class="h-screen w-full flex items-center justify-center"> {{ mode }} </h1>
    </NuxtLayout>
  </div>
</template>

