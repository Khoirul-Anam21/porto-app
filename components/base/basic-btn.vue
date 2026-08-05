<template>
    <button>
        Button
    </button>
</template>

<style scoped>
button {
    font-family: monospace;
    font-size: 1.5rem;
    color: white;
    text-transform: uppercase;
    padding: 10px 20px;
    border-radius: 10px;
    border: none;
    background: linear-gradient(135deg, #6B8F3C 0%, #4A6B28 100%);
    box-shadow: 0 2px 8px rgba(107, 143, 60, 0.3);
    cursor: pointer;
    margin: 35px 0;
    transition: all 0.2s ease;
}

button:hover {
    box-shadow: 0 4px 12px rgba(107, 143, 60, 0.4);
    transform: translateY(-1px);
}

button:active {
    box-shadow: 0 1px 4px rgba(107, 143, 60, 0.3);
    transform: translateY(1px);
}
</style>