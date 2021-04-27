// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import axios from "axios"
import $ from 'jquery'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

Rails.start()
Turbolinks.start()
ActiveStorage.start()

const handleHeartDisplay = (alreadyLiked) => {
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
