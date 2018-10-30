$(function() {
  $('.nice').on('click', function() {
    $(this).css('color','#cfd8dc');
    $(this).removeClass('nice');
    $(this).addClass('unice');
  });
  $('.unice').on('click', function() {
    $(this).css('color','#03a9f4');
    $(this).removeClass('unice');
    $(this).addClass('nice');
  });
});
