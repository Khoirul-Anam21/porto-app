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
        techstacks: ["Vue.js", "Express.js", "MongoDB", "TypeScript"],
    },
    {
        title: "Think Action",
        thumbnail: "https://res.cloudinary.com/anamcloud/image/upload/v1694623156/Screenshot_2023-09-13_232607-min_b4soxm.png",
        description: 'Lorem Ipsum dolor sit amet',
        link: 'https://anam-lms-app.vercel.app/',
        repo: "https://github.com/Khoirul-Anam21/lms-cataliz-FE",
        techstacks: ["Express.js", "MongoDB", "TypeScript"],
    },
])