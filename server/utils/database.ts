import { Pool, PoolClient } from 'pg'

let pool: Pool | null = null

/**
 * Get or create the database connection pool
 * Reuses connections for efficiency
 */
export function getPool(): Pool {
  if (!pool) {
    const config = useRuntimeConfig()
    
    console.log('🔌 Creating database connection pool...')
    console.log('   Host:', config.dbHost)
    console.log('   Port:', config.dbPort)
    console.log('   Database:', config.dbName)
    
    pool = new Pool({
      host: config.dbHost,
      port: parseInt(config.dbPort),
      database: config.dbName,
      user: config.dbUser,
      password: config.dbPassword,
      ssl: {
        rejectUnauthorized: false // Required for Aiven
      },
      // Connection pool settings - OPTIMIZED for Aiven free tier
      max: 5,                      // ⬇️ Reduced from 20 (Aiven free tier ~20 total)
      min: 1,                      // Keep at least 1 connection ready
      idleTimeoutMillis: 10000,    // ⬇️ Close idle connections after 10s
      connectionTimeoutMillis: 5000, // Increase connection timeout
      statement_timeout: 30000, // Statement timeout 30s
    })

    // Handle pool errors
    pool.on('error', (err) => {
      console.error('❌ Pool error:', err.message)
    })

    pool.on('connect', () => {
      console.log('✅ New connection created')
    })

    pool.on('remove', () => {
      console.log('♻️  Connection removed from pool')
    })

    console.log('✅ Connection pool created (max 5 connections)')
  }

  return pool
}

/**
 * Execute a query and automatically release the connection
 * Usage: await query('SELECT * FROM table WHERE id = $1', [id])
 */
export async function query(
  text: string,
  params: any[] = []
): Promise<any[]> {
  const pool = getPool()
  const client = await pool.connect()
  
  try {
    // Set query timeout
    await client.query('SET statement_timeout = 30000')
    
    const result = await client.query(text, params)
    return result.rows
  } catch (err: any) {
    console.error('❌ Database query error:', {
      message: err.message,
      code: err.code,
      query: text.substring(0, 100) + '...'
    })
    throw err
  } finally {
    // Always release connection back to pool
    try {
      client.release()
    } catch (releaseErr: any) {
      console.error('❌ Error releasing connection:', releaseErr.message)
    }
  }
}

/**
 * Execute a single row query
 * Returns first row or null
 */
export async function queryOne(
  text: string,
  params: any[] = []
): Promise<any | null> {
  const rows = await query(text, params)
  return rows.length > 0 ? rows[0] : null
}

/**
 * Close the pool (useful for graceful shutdown)
 */
export async function closePool(): Promise<void> {
  if (pool) {
    try {
      await pool.end()
      console.log('✅ Connection pool closed')
    } catch (err: any) {
      console.error('❌ Error closing pool:', err.message)
    }
    pool = null
  }
}
