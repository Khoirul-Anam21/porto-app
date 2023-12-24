export interface ProjectInterface {
    title: string;
    thumbnail: string;
    description: string;
    repo: string;
    link: string;
    techstacks: string[];
}

export const projectData: Ref<ProjectInterface[]> = ref([
    {
        title: "LMS Application",
        thumbnail: "https://res.cloudinary.com/anamcloud/image/upload/v1694623156/Screenshot_2023-09-13_232607-min_b4soxm.png",
        description: 'An LMS application that facilitates the students and teachers through learning platform',
        repo: "https://github.com/Khoirul-Anam21/lms-cataliz-FE",
        link: 'http://think-action-api.ap-southeast-2.elasticbeanstalk.com/',
        techstacks: ["Vue.js", "Express", "MongoDB", "TypeScript"],
    },
    {
        title: "Think Action",
        thumbnail: "https://res.cloudinary.com/anamcloud/image/upload/v1694654440/api-doc_mgpoqh.png",
        description: 'A REST API of a social media app that mainly about goal achievements',
        link: 'https://documenter.getpostman.com/view/19302442/2s9YC4WDPm',
        repo: "https://github.com/Khoirul-Anam21/think-action-BE",
        techstacks: ["Express", "MongoDB", "TypeScript"],
    },
    {
        title: "Personal Website",
        thumbnail: "https://res.cloudinary.com/anamcloud/image/upload/v1694654441/personal-web_mwkbs5.png",
        description: 'My own personal website for the repository of portofolios and my CV',
        link: 'https://anam-lms-app.vercel.app/',
        repo: "https://github.com/Khoirul-Anam21/porto-app",
        techstacks: ["Express", "MongoDB", "TypeScript"],
    },
])