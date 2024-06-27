<template>
    <div class="loader">
        <div class="circle" tabindex="0"></div>
        <div class="circle" tabindex="0"></div>
        <div class="circle" tabindex="0"></div>
        <div class="circle" tabindex="0"></div>
        <div class="circle" tabindex="0"></div>
    </div>
</template>

<style scoped>
/* Container for the loader */
.loader {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 3em;
}

/* Circle elements */
.circle {
    width: 1em;
    height: 1em;
    margin: 0 0.25em;
    border-radius: 50%;
    background-color: #e2f9ff;
    border: 2px;
    border-style: solid;
    border-color: black;
    animation: wave 1.5s infinite ease-in-out;
    transition: background-color 0.3s ease;
}

/* Animation */
@keyframes wave {

    0%,
    100% {
        transform: translateY(0);
    }

    50% {
        transform: translateY(-1em);
    }
}

/* Delay for each circle */
.circle:nth-child(1) {
    animation-delay: 0s;
}

.circle:nth-child(2) {
    animation-delay: 0.2s;
}

.circle:nth-child(3) {
    animation-delay: 0.4s;
}

.circle:nth-child(4) {
    animation-delay: 0.6s;
}

.circle:nth-child(5) {
    animation-delay: 0.8s;
}
</style>