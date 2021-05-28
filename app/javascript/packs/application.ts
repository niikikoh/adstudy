//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap';
import axios from "axios"
import $ from 'jquery'
import { csrfToken } from 'rails-ujs'

require("trix")
require("@rails/actiontext")

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function() {
    const btn = document.getElementById('dropdown__btn');
    if(btn) {
        btn.addEventListener('click', function(){
            console.log('aaaa')
            this.classList.toggle('is-open');
        })
    }
})

document.addEventListener('turbolinks:load', function() {
    const btn = document.getElementById('article__btn');
    if(btn) {
        btn.addEventListener('click', function(){
            console.log('aaaa')
            this.classList.toggle('is-open');
        })
    }
})

const handleHeartDisplay = (alreadyLiked: any) => {
    if (alreadyLiked) {
        $('.active-heart').removeClass('hidden')
    } else {
        $('.non-active-heart').removeClass('hidden')
    }
}

document.addEventListener('turbolinks:load', () => {
    const dataset = $('#article-show').data()
    const articleId = dataset.articleId

    axios.get(`/articles/${articleId}/like`)
      .then((response) => {
          const alreadyLiked = response.data.alreadyLiked
          handleHeartDisplay(alreadyLiked)  
      })

    $('.non-active-heart').on('click', () => {
        axios.post(`/articles/${articleId}/like`)
          .then((response) => {
            if (response.data.status === 'ok') {
                $('.active-heart').removeClass('hidden')
                $('.non-active-heart').addClass('hidden')
            }
          })
          .catch((e) => {
              window.alert('error')
              console.log(e)
          })
    })

    $('.active-heart').on('click', () => {
        axios.delete(`/articles/${articleId}/like`)
          .then((response) => {
            if (response.data.status === 'ok') {
                $('.active-heart').addClass('hidden')
                $('.non-active-heart').removeClass('hidden')
            }
          })
          .catch((e) => {
              window.alert('error')
              console.log(e)
          })
    })
})

