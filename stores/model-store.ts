export interface Language {
    readonly id: number;
    readonly date_created: Date;
    readonly date_updated: Date;
    readonly name: string;
    readonly level_types: string;
    levels: (Level | number | string)[];
}
export interface Level {
    readonly date_created: string
    readonly date_updated: any
    readonly id: number
    readonly level_name: string
    readonly sort: any
    readonly status: string
    readonly user_created: string
    readonly user_updated: any
}


export interface MainContent {
    readonly id: number;
    readonly date_created: Date;
    readonly user_updated: string;
    readonly date_updated: Date;
    readonly about_desc: string;
    readonly project_desc: string;
    readonly education_desc: string;
    readonly experience_desc: string;
    readonly specialties: Specialty[];
    readonly languages: Language[];
}

export interface ProjectType {
    readonly id: number;
    readonly name: string;
    readonly icon: string;
}

export interface Education {
    readonly institution: string;
    readonly id: number;
    readonly date_created: Date;
    readonly user_updated: string;
    readonly major: string;
    readonly date_updated: Date;
    readonly is_active: boolean;
    readonly date_start: Date;
    readonly education_type: string;
    readonly sequence: number;
    readonly date_end: Date | null;
    readonly gpa: null | string;
    readonly detail: null;
}

export interface ProjectFiles {
    readonly id: number;
    readonly projects_id: null;
    readonly directus_files_id: string;
}

export interface Specialty {
    readonly id: number;
    readonly title: string;
    readonly is_active: boolean;
    readonly user_updated: string;
    readonly date_created: Date;
    readonly description: string;
    readonly date_updated: Date;
    readonly icon: string;
}

export interface Experience {
    readonly id: number;
    readonly date_created: Date;
    readonly user_updated: string;
    readonly company: string;
    readonly is_active: boolean;
    readonly date_updated: Date;
    readonly position: string;
    readonly date_start: Date;
    readonly date_end: Date | null;
    readonly job_type: number;
    readonly job_detail: string;
    readonly sequence: number;
}

export interface ExperienceType {
  readonly id: number
  readonly sort: any
  readonly user_updated: any
  readonly date_updated: any
  readonly user_created: string
  readonly name: string
  readonly status: string
  readonly date_created: string
}

export interface ExperienceDetail {
    readonly job_detail: string;
}

export interface Project {
    readonly id: number;
    readonly date_created: Date;
    readonly user_updated: string;
    readonly is_active: boolean;
    readonly date_updated: Date;
    readonly title: string;
    readonly detail: null | string;
    readonly short_desc: string;
    readonly type: number;
    readonly skills_used: any[];
    readonly images: any[];
}

export interface Skill {
    readonly id: number;
    readonly date_created: Date;
    readonly user_updated: null | string;
    readonly date_updated: Date | null;
    readonly title: string;
    readonly icon: string;
    readonly skill_icon_title: string;
}

