# 09 - Database Guide

## Database Technology

- **Engine**: PostgreSQL 17.9
- **Host**: Aiven Cloud (free tier)
- **Client**: `pg` (node-postgres) ^8.11.3
- **ORM**: None — raw SQL queries
- **Schema Origin**: Originally managed by Directus CMS, now accessed directly

## Connection Configuration

From `server/utils/database.ts`:
```typescript
pool = new Pool({
    host: config.dbHost,         // Aiven host
    port: parseInt(config.dbPort), // 5432
    database: config.dbName,     // defaultdb
    user: config.dbUser,         // avnadmin
    password: config.dbPassword,
    ssl: { rejectUnauthorized: false },  // Required for Aiven
    max: 5,                      // Free tier limit
    idleTimeoutMillis: 10000,
    connectionTimeoutMillis: 5000,
    statement_timeout: 30000,
})
```

## Schema Structure

### Business Tables

#### `main_contents` — Singleton (about page content)
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | 'draft' or 'published' |
| about_desc | text | About Me description |
| project_desc | text | |
| education_desc | text | |
| experience_desc | text | |
| date_created | timestamptz | |
| date_updated | timestamptz | |

#### `specialties` — Main page specialty cards
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| sort | bigint | Display order |
| title | varchar(255) | |
| description | text | |
| icon | char(36) | Directus file reference |

#### `languanges` — Language proficiency (note: typo in table name)
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| sort | bigint | |
| name | varchar(255) | e.g., "English", "Japanese" |
| level_types | text | JSON array stored as text, parsed client-side |

**Note**: The table name `languanges` is a typo (should be `languages`). This is legacy from Directus.

#### `projects` — Portfolio projects
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| sort | bigint | Display order (DESC) |
| title | varchar(255) | |
| description | text | Short description |
| detail | text | HTML content (rendered with v-html) |
| type | bigint | FK → project_types.id |
| repo_Link | text | GitHub repo URL |
| Url | text | Live demo URL |

#### `project_types` — Project categories
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| sort | bigint | |
| name | varchar(255) | e.g., "Web App", "Mobile App" |
| icon | char(36) | Directus file reference |

#### `projects_files` — Project images (M2M via junction table)
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| projects_id | bigint | FK → projects.id |
| directus_files_id | char(36) | Directus file ID |

#### `projects_skills` — Project-skill relationship (M2M)
| Column | Type | Notes |
|--------|------|-------|
| id | integer (PK) | |
| projects_id | bigint | FK → projects.id |
| skills_id | bigint | FK → skills.id |

#### `experiences` — Work experience
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| sort | bigint | |
| company | varchar(255) | |
| position | varchar(255) | |
| date_start | timestamptz | |
| date_end | timestamptz | NULL = currently working |
| job_detail | text | HTML content |
| job_type | bigint | FK → job_types.id |
| sequence | bigint | Display order |

#### `job_types` — Experience type categories
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| name | varchar(255) | e.g., "Full-time", "Internship" |

#### `experiences_skills` — Experience-skill relationship (M2M)
| Column | Type | Notes |
|--------|------|-------|
| id | integer (PK) | |
| experiences_id | bigint | FK → experiences.id |
| skills_id | bigint | FK → skills.id |

#### `skills` — Technical skills
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| sort | bigint | |
| title | varchar(255) | e.g., "Vue.js", "Nuxt" |
| icon | char(36) | Directus file reference |

#### `educations` — Education history
| Column | Type | Notes |
|--------|------|-------|
| id | bigint (PK) | |
| status | varchar(255) | |
| sort | bigint | |
| institution | varchar(255) | |
| major | varchar(255) | |
| date_start | timestamptz | |
| date_end | timestamptz | NULL = currently studying |
| sequence | bigint | Display order |
| education_type | varchar(255) | e.g., "Bachelor's", "Bootcamp" |
| detail | text | |

## Relationships

```
project_types 1──N projects N──M skills (via projects_skills)
                               N──M files (via projects_files)

job_types 1──N experiences N──M skills (via experiences_skills)

specialties (standalone)
languanges (standalone, JSON in level_types)
educations (standalone)
main_contents (standalone singleton)
```

**No foreign key constraints are defined in the SQL dump** — relationships are enforced only at the application level.

## Query Patterns

### Filtered by Status
Every query filters by `status = 'published'`:
```sql
SELECT ... FROM table WHERE status = $1
```

### Ordering
- `sort ASC` for specialties, skills, languages
- `sort DESC` for projects
- `sequence ASC` for experiences, educations
- Client-side sorting: `experiences?.sort((a, b) => b.sequence - a.sequence)`

### Batch Fetching (N+1 Avoidance)
```sql
-- Fetch all related records at once
SELECT ... FROM projects_files WHERE projects_id = ANY($1)
SELECT ... FROM skills JOIN projects_skills ON ... WHERE projects_id = ANY($1)
```

### JSON-in-Text
```sql
-- Languages store levels as JSON text
SELECT id, name, level_types FROM languanges
-- Client-side: JSON.parse(language.level_types)
```

## Indexing Strategy

**No custom indexes defined.** The database relies on:
- Primary key indexes (auto-created)
- Sequential scans (acceptable for small dataset — portfolio has ~50-100 records)

**Evidence**: The SQL dump shows no `CREATE INDEX` statements for business tables.

## Business Entities

| Entity | Count (approx) | Description |
|--------|----------------|-------------|
| main_contents | 1 | Singleton about page |
| specialties | 3-5 | Skill categories on home page |
| languanges | 2-3 | Language proficiencies |
| projects | 5-10 | Portfolio projects |
| project_types | 2-4 | Project categories |
| experiences | 3-5 | Work experiences |
| job_types | 2-3 | Employment types |
| skills | 10-20 | Technical skills |
| educations | 2-4 | Education records |
