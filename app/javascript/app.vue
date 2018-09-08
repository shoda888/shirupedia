<template>
    <div id='hello'>
        {{message}}
    </div>
</template>

<script>
    console.log('hi vue')
    export default {
        data: function () {
            return {
                message: "Hello Vue!",
            }
        }
    }
</script>

<style scoped>
    p {
        font-size: 2em;
        text-align: center;
    }
</style>
