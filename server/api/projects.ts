import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    console.log('📡 Fetching project types...')
    
    // Fetch project types
    const types = await query(
      `SELECT id, name, icon_img
       FROM project_types 
       WHERE status = $1`,
      ['published']
    )
    console.log('✅ Project types:', types.length)

    // Fetch projects with images and skills in one query
    console.log('📡 Fetching projects...')
    
    // Get all projects
    const projectsRaw = await query(
      `SELECT DISTINCT
        p.id,
        p.title,
        p.description,
        p.detail,
        p.type,
        p.sort
       FROM projects p
       WHERE p.status = $1 
       ORDER BY p.sort DESC`,
      ['published']
    )
    console.log('✅ Projects found:', projectsRaw.length)

    // Fetch images for all projects at once
    const allImages = await query(
      `SELECT id, projects_id, directus_files_id
       FROM projects_files 
       WHERE projects_id = ANY($1)`,
      [projectsRaw.map(p => p.id)]
    )

    // Fetch skills for all projects at once
    const allSkills = await query(
      `SELECT s.id, s.title, s.icon, ps.projects_id
       FROM skills s
       JOIN projects_skills ps ON s.id = ps.skills_id
       WHERE ps.projects_id = ANY($1)`,
      [projectsRaw.map(p => p.id)]
    )

    // Map images and skills back to projects
    const projects = projectsRaw.map(project => ({
      ...project,
      images: allImages.filter(img => img.projects_id === project.id),
      skills_used: allSkills.filter(skill => skill.projects_id === project.id)
    }))

    console.log('✅ Projects endpoint success, returned', projects.length, 'projects')
    
    return {
      types,
      projects
    }
  } catch (err: any) {
    console.error('❌ Failed to fetch projects:')
    console.error('Error type:', err.constructor.name)
    console.error('Error message:', err.message)
    console.error('Full error:', err)
    
    throw createError({
      statusCode: 500,
      statusMessage: 'Database Error',
      data: {
        message: err.message,
        hint: 'Check database connection and Aiven limits'
      }
    })
  }
})
