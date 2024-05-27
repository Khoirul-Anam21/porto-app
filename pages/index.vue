<script setup lang="ts">

const currentOption: Ref<String | null> = ref('')

const changeOption = (newOpt: string) => {
  currentOption.value = newOpt
}

</script>

<template>
  <section class="scroll-smooth">
    <!-- <h1>{{ currentOption }} hei</h1> -->
    <div id="main" class=" h-screen flex flex-col justify-start gap-4">
      <MainBaseOption :data="['Hello', 'There', 'Hi']" @update-current-option="changeOption" />
      <MainBaseAccordion>
        <MainBaseAccordionItem :item-id="0" >
          <template #header>
            <div>
              This is the header
            </div>
          </template>
          <template #default>
            <div>
              this is the child
            </div>
          </template>
        </MainBaseAccordionItem>
        <MainBaseAccordionItem :item-id="1" >
          <template #header>
            <div>
              This is the header
            </div>
          </template>
          <template #default>
            <div>
              this is the child
            </div>
          </template>
        </MainBaseAccordionItem>
        <MainBaseAccordionItem :item-id="2" >
          <template #header>
            <div>
              This is the header
            </div>
          </template>
          <template #default>
            <div>
              this is the child
            </div>
          </template>
        </MainBaseAccordionItem>
      </MainBaseAccordion>
    </div>
  </section>
</template>