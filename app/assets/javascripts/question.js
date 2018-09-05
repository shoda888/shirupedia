$(document).ready(function() {
  $(document).on("click", ".answer-btn", function(){
    $('.answer-form').show();
  });
  $(document).on("click", ".client-avatar", function(){
    //ブラウザ戻る対策しないといけない!!
    // e.preventDefault();
    // $('.client-avatar').closest('div[class^=iziModal2]').iziModal('resetContent');
    // $('.iziModal').addClass("comingOut");
    // $('.iziModal').attr('area-hidden', 'true');
    // $('.iziModal-overlay').addClass("fadeOut");
    //
    // $('.iziModal').removeClass("comingOut");
    // $('.iziModal').attr('area-hidden', 'false');
    // $('.iziModal-overlay').removeClass("fadeOut");
    // $('.iziModal-header').attr('area-hidden', 'true');
    // $('.iziModal-wrap').hide();
  });
  $(function() {
    function buildHTML(photo) {
      var html = $('<div class="new-answer">').append("<img src=" + photo + "></img>");
      return html;
    }
    //submitイベントを使い、フォームが送信された時に処理が実行されるようにイベントを設定。
    $('.answer-form').on('submit', function(e) {
      e.preventDefault(); //フォームが送信された時に、デフォルトだとフォームを送信するための通信がされてしまうので、preventDefault()を使用してデフォルトのイベントを止めます。
      var formdata = new FormData($(this).get(0));  //フォームデータ取得
      var url = $(this).get(0).action + '.json'
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
        $('.new-answers').append(html);
        fileField.val('');
      })
      //↓フォームの送信に失敗した場合の処理
      .fail(function() {
        alert('error');
      });
    });
  });
});
