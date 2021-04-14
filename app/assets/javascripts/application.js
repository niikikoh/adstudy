//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap
//= require_tree .

// ドロップダウンのJS
$(function(){
  $('.dropdown').hover(function(){
    $(this).children('ul').show();
  }, function(){
      $(this).children('ul').hide();
  });
});