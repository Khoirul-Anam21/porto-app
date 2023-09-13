<template>
    <div class="mx-20">
      <div id="main" class="h-screen pt-24 flex items-center justify-center">
        <MainPageComponent />
      </div>
      <div id="about" class="h-screen w-full flex items-center pt-24 justify-center">
        <AboutPageComponent />
      </div>
      <div id="skill" class="relative h-screen border-4 pt-24 border-y-primary-dark  dark:border-y-turquoise my-10 ">
        <SkillPageComponent />
      </div>
      <div id="project" class="relative h-screen pt-24 flex items-center justify-center">
        <ProjectPageComponent />
      </div>
      <div id="experience" class="relative h-screen pt-24 flex items-start justify-center">
        <ExperiencePageComponent />
      </div>

    </div>
</template>