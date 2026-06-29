import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    console.log('📡 Fetching educations...')
    
    const educations = await query(
      `SELECT 
        id,
        institution,
        major,
        education_type,
        date_start,
        date_end,
        sequence,
        detail
       FROM educations 
       WHERE status = $1 
       ORDER BY sequence ASC`,
      ['published']
    )

    console.log('✅ Educations endpoint success, returned', educations.length, 'records')
    return educations
    
  } catch (err: any) {
    console.error('❌ Failed to fetch educations:')
    console.error('Error type:', err.constructor.name)
    console.error('Error message:', err.message)
    console.error('Full error:', err)
    
    throw createError({
      statusCode: 500,
      statusMessage: 'Database Error',
      data: {
        message: err.message,
        hint: 'Check database connection'
      }
    })
  }
})
