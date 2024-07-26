export default defineEventHandler(async (event) => {
    try {
        const [projectsResult, types] = await Promise.all([
            await $fetch(`https://admin.anam6.my.id/items/projects`, {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }) as Promise<any>,
            await $fetch(`https://admin.anam6.my.id/items/project_types`, {
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