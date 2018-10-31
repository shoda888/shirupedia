import Vue from 'vue/dist/vue.esm';
import Profile from '../profile.vue'

document.addEventListener('DOMContentLoaded', () => {

    new Vue({
        el: '#profile',
        components: { Profile },
    })
})
