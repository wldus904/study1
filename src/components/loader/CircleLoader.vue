<template>
    <div class="loader-panel">
        <v-progress-circular
            :size="70"
            width="13"
            color="main"
            indeterminate
            class="loader"
        ></v-progress-circular>
    </div>
</template>
<style>
.loader-panel {
    position: fixed;
    background-color: rgba(0, 0, 0, 0.5);
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}
.loader {
    position: fixed;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
}
</style>
