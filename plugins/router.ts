import { defineNuxtPlugin } from "#app";
// import { RouteLocationNormalized } from "#app/router";

export default defineNuxtPlugin((nuxtApp) => {
  const $router = nuxtApp.$router as any;

  $router.options.scrollBehavior = (
    to: any,
    from: any,
    savedPosition: any
  ): any => {
    if (to.hash) {
      return {
        el: to.hash,
        top: 30,
        behavior: "smooth",
      };
    }
  };
});