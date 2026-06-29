import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    console.log('📡 Fetching job types...')
    
    // Fetch job types
    const types = await query(
      `SELECT id, name, status
       FROM job_types 
       WHERE status = $1`,
      ['published']
    )
    console.log('✅ Job types:', types.length)

    // Fetch experiences
    console.log('📡 Fetching experiences...')
    const experiences = await query(
      `SELECT 
        id,
        company,
        position,
        job_type,
        job_detail,
        date_start,
        date_end,
        sequence
       FROM experiences 
       WHERE status = $1 
       ORDER BY sequence ASC`,
      ['published']
    )
    console.log('✅ Experiences:', experiences.length)

    console.log('✅ Experiences endpoint success')
    
    return {
      types,
      experiences
    }
    
  } catch (err: any) {
    console.error('❌ Failed to fetch experiences:')
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
