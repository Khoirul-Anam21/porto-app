export default defineEventHandler(async (event) => {
    try {
        const config = useRuntimeConfig()

        const [experienceResult, experienceType] = await Promise.all([
            await $fetch(`${config.public.apiBase}/items/experiences`, {
                method: "GET",
                headers: { "Content-Type": "application/json" },
            }) as Promise<any>,
            await $fetch(`${config.public.apiBase}/items/job_types`, {
                method: "GET",
                headers: { "Content-Type": "application/json" },
            }) as Promise<any>,
        ]);
        const result: any = await $fetch(`${config.public.apiBase}/items/experiences`, {
            method: "GET",
            headers: { "Content-Type": "application/json" },
        });

        const response = {
            types: experienceType.data,
            experiences: experienceResult.data,
        }

        
        return JSON.stringify(response);
    } catch (err) {
        throw createError({
            message: "Failed to fetch data",
            statusCode: 404,
        });
    }

})