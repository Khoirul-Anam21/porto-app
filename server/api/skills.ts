import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    console.log('📡 Fetching skills...')
    
    const skills = await query(
      `SELECT id, title, icon, icon_url
       FROM skills 
       WHERE status = $1 
       ORDER BY sort ASC`,
      ['published']
    )

    console.log('✅ Skills endpoint success, returned', skills.length, 'records')
    return skills
    
  } catch (err: any) {
    console.error('❌ Failed to fetch skills:')
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
