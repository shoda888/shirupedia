<template>
    <p>
        {{message}}
    </p>
</template>

<script>
    export default {
        data: function () {
            return {
                message: "入力!",
            }
        }
    }
</script>

<style scoped>
    p {
        font-size: 30px;
        text-align: center;
    }
</style>
