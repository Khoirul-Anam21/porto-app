export default defineEventHandler(async (event) => {
    try {
        const config = useRuntimeConfig()

        const result: any = await $fetch(`${config.public.apiBase}/items/educations`, {
            method: "GET",
            headers: { "Content-Type": "application/json" },
        });

        return JSON.stringify(result.data);
        
    } catch (err) {
        throw createError({
            message: "Failed to fetch data",
            statusCode: 404,
        });
    }

})