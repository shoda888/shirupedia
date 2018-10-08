$(function() {
  $('.favorite').on('click', function() {
    $(this).find('.like').css('color','black');
    $(this).toggleClass('uniine');
    $(this).find('.material-icons').html('favorite_border');
  });
  $('.cancel-favorite').on('click', function() {
    $(this).find('.uniine').css('color','red');
    $(this).toggleClass('like');
    $(this).find('.material-icons').html('favorite');
  });
});
