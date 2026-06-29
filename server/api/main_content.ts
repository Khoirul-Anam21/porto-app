import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    console.log('📡 Fetching main content...')
    
    // Fetch main content
    const mainContent = await query(
      `SELECT id, about_desc, project_desc, education_desc, experience_desc 
       FROM main_contents 
       WHERE status = $1 
       LIMIT 1`,
      ['published']
    )

    console.log('✅ Main content:', mainContent)

    if (!mainContent || mainContent.length === 0) {
      throw new Error('Main content not found in database')
    }

    // Fetch specialties
    console.log('📡 Fetching specialties...')
    const specialties = await query(
      `SELECT id, title, description, icon_img
       FROM specialties 
       WHERE status = $1 
       ORDER BY sort ASC`,
      ['published']
    )
    console.log('✅ Specialties:', specialties.length)

    // Fetch languages with levels
    console.log('📡 Fetching languages...')
    const languages = await query(
      `SELECT id, name, level_types
       FROM languanges 
       WHERE status = $1 
       ORDER BY sort ASC`,
      ['published']
    )
    console.log('✅ Languages:', languages.length)

    // Combine all data
    const response = {
      ...mainContent[0],
      specialties,
      languages
    }

    console.log('✅ Main content endpoint success')
    return response
  } catch (err: any) {
    console.error('❌ Failed to fetch main content:')
    console.error('Error type:', err.constructor.name)
    console.error('Error message:', err.message)
    console.error('Full error:', err)
    
    throw createError({
      statusCode: 500,
      statusMessage: 'Database Error',
      data: {
        message: err.message,
        hint: 'Check .env.local credentials and Aiven database connection'
      }
    })
  }
})
