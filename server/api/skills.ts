export default defineEventHandler(async (event) => {
    try {
        const result: any = await $fetch(`https://admin.anam6.my.id/items/skills`, {
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