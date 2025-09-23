export default defineEventHandler(async (event) => {
    try {
        const config = useRuntimeConfig()

        const [projectsResult, types] = await Promise.all([
            await $fetch(`${config.public.apiBase}/items/projects?fields=*,images.*`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
            await $fetch(`${config.public.apiBase}/items/project_types`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
        ]);

        const response = {
            types: types.data,
            projects: projectsResult.data,
        }

        
        return JSON.stringify(response);
        
    } catch (err) {
        throw createError({
            message: "Failed to fetch data",
            statusCode: 404,
        });
    }

})