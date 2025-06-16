import { Language, Level, MainContent, Specialty } from "~/stores/model-store";

export default defineEventHandler(async (event) => {
    console.log("Fetching main content...");

    try {
        const config = useRuntimeConfig()

        // const [mainContentResult, specialtiesResult, languagesResult] = await Promise.all([
        //     await $fetch(`${config.public.apiBase}/items/main_contents`, {
        //         method: "GET",
        //         headers: { "Content-Type": "application/json" }
        //     }) as Promise<any>,
        //     await $fetch(`${config.public.apiBase}/items/specialties`, {
        //         method: "GET",
        //         headers: { "Content-Type": "application/json" }
        //     }) as Promise<any>,
        //     await $fetch(`${config.public.apiBase}/items/languages`, {
        //         method: "GET",
        //         headers: { "Content-Type": "application/json" }
        //     }) as Promise<any>,
        // ]);

        const [mainContentResult, specialtiesResult, languagesResult] = await Promise.all([
            await $fetch(`${config.public.apiBase}/items/main_contents`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
            await $fetch(`${config.public.apiBase}/items/specialties`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
            await $fetch(`${config.public.apiBase}/items/languanges`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
        ]);

        // console.log(languagesResult.data);
                
        const response = {
            ...mainContentResult.data,
            specialties: specialtiesResult.data,
            languages: languagesResult.data
        }

        return JSON.stringify(response)
    } catch (err) {
        throw createError({
            message: "Failed to fetch data",
            statusCode: 404,
        });
    }

})