<template>
    <div class="">
      <div id="main" class=" h-screen flex items-center justify-center">
        <MainPageComponent />
      </div>
      <div id="about" class="px-10 md:px-20 h-screen w-full flex items-center pt-24 justify-center">
        <AboutPageComponent />
      </div>
      <div id="skill" class="px-10 md:px-20 relative min-h-screen border-4 pt-24 border-y-primary-dark  dark:border-y-turquoise my-10 ">
        <SkillPageComponent />
      </div>
      <div id="project" class="px-14 md:px-20 relative h-screen pt-24 fle flex-col items-center justify-center">
        <ProjectPageComponent />
      </div>
      <div id="experience" class="px-10 md:px-20 relative h-screen pt-24 flex items-start justify-center">
        <ExperiencePageComponent />
      </div>
      <div id="contact" class="h-[50vh] px-10 md:px-20 flex items-center justify-center bg-dark-turquoise dark:bg-turquoise">
        <ContactPageComponent />
      </div>

    </div>
</template>