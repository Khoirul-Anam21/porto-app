import { Language, MainContent, Specialty } from "~/stores/model-store";

export default defineEventHandler(async (event) => {


    try {
        const [mainContentResult, specialtiesResult, languagesResult] = await Promise.all([
            await $fetch(`https://admin.anam6.my.id/items/main_content`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
            await $fetch(`https://admin.anam6.my.id/items/specialties`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
            await $fetch(`https://admin.anam6.my.id/items/languages`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
        ]);

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