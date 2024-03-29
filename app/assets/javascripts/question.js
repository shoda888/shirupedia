$(function() {
  $('.tooltipped').tooltip();
  $('.materialboxed').materialbox();
  $('.carousel').carousel({
    fullWidth: true,
    indicators: true
  });
  $('.chip').on('click', function(e) {
    e.stopPropagation();
    document.location = "/questions?fields=" + e.target.innerText;
  });
  $('.grid').imagesLoaded( function() {
    $('.grid').masonry({
          itemSelector: '.grid-item',
          columnWidth: '.grid-sizer',
          percentPosition: true
    });
  });
  $(document).on("click", ".comment-btn", function(){
    $(this).parent().siblings('.comment-form').toggle();
    $('.photo-grid').masonry({
          itemSelector: '.photo-grid-item',
          columnWidth: '.photo-grid-sizer',
          percentPosition: true
    });
  });
  $(document).on("ajax:complete", '.delete_button', function(e){
    result = JSON.parse(e.originalEvent.detail[0].response);
    $('#cover_'+ result.id).fadeOut();
  });
  $(".answer-photo").dropzone({
    maxFilesize: 2,
    maxFiles: 5,
    addRemoveLinks: true,
    dictRemoveFile:'削除',
    parallelUploads: 5,
    paramName: 'photo_message',
    init: function() {
    },
    success: function(file, response){
      $(file.previewElement).find('.dz-remove').attr('id',response.itemId);
      $(file.previewElement).addClass('dz-success');
    },
    removedfile: function(file){
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');
      $.ajax({
        type: 'DELETE',
        url: "/covers/" + id
      });

      var previewElement;
      return (previewElement = file.previewElement) != null ? (previewElement.parentNode.removeChild(file.previewElement)) : (void 0);
    }
  });
});
