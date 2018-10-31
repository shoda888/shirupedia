import Vue from 'vue/dist/vue.esm';
import Information from '../information.vue'

document.addEventListener('DOMContentLoaded', () => {

    const app = new Vue({
        el: '#information',
        components: { Information }
    })
})
