import Vue from 'vue'
import Profile from '../profile.vue'

document.addEventListener('DOMContentLoaded', () => {

    new Vue({
        el: '#profile',
        components: { Profile },
    })
})
