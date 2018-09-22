$(function() {
  $('.materialboxed').materialbox();
  $('.modal').modal({
    onOpenEnd: function() {
      $('.photo-grid').masonry({
            itemSelector: '.photo-grid-item',
            columnWidth: '.photo-grid-sizer',
            percentPosition: true
      });
    }
  });
  $('.modal-title').css('font-family','season');
  $('.carousel').carousel({
    fullWidth: true,
    indicators: true
  });
  $('.grid').masonry({
        itemSelector: '.grid-item',
        columnWidth: '.grid-sizer',
        percentPosition: true
  });
  $(document).on("click", ".answer-btn", function(){
    $('.answer-form').show();
  });
  //submitイベントを使い、フォームが送信された時に処理が実行されるようにイベントを設定。
  $('.answer-form').on('submit', function(e) {
    e.preventDefault(); //フォームが送信された時に、デフォルトだとフォームを送信するための通信がされてしまうので、preventDefault()を使用してデフォルトのイベントを止めます。
    var ans_form = $(this);
    var formdata = new FormData(ans_form.get(0));  //フォームデータ取得
    var url = ans_form.get(0).action + '.json'
    $.ajax({
      type: 'POST',
      url: url,
      data: formdata,
      processData: false,
      contentType: false
    })
    //↓フォームの送信に成功した場合の処理
    .done(function(data) {
      var html = buildHTML(data.url);
      ans_form.siblings('.new-answers').append(html);
    })
    //↓フォームの送信に失敗した場合の処理
    .fail(function() {
      alert('error');
    });
  });
  function buildHTML(photo) {
    var html = $('<div class="new-answer">').append("<img src=" + photo + "></img>");
    return html;
  }
  // });
});
