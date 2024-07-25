export default defineEventHandler(async (event) => {
    try {
        const result: any = await $fetch(`https://admin.anam6.my.id/items/projects`, {
            method: "GET",
            headers: { "Content-Type": "application/json" },
        });
        return {
            data: result.data
        }
    } catch (err) {
        throw createError({
            message: "Failed to fetch data",
            statusCode: 404,
        });
    }

})