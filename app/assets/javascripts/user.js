$(document).ready(function() {
  $(function() {
    // function buildHTML(photo) {
      // var html = $('<div class="new-answer">').append("<img src=" + photo + "></img>");
      // return html;
    // }
    //submitイベントを使い、フォームが送信された時に処理が実行されるようにイベントを設定。
    $('.user_signup_form').on('submit', function(e) {
      e.preventDefault(); //フォームが送信された時に、デフォルトだとフォームを送信するための通信がされてしまうので、preventDefault()を使用してデフォルトのイベントを止めます。
      var user_form = $(this);
      var formdata = new FormData(user_form.get(0));  //フォームデータ取得
      var url = user_form.get(0).action + '.json'
      $.ajax({
        type: 'POST',
        url: url,
        data: formdata,
        processData: false,
        contentType: false
      })
      //↓フォームの送信に成功した場合の処理
      .done(function(data) {
        user_form.hide();
        $('.btn-to-login').hide();
        var html = '<div class="success-msg">ご入力されたmアドレスにメールを送信しました。メール内のリンクからユーザー登録を完了させてください。</div>';
        $('.card-content').append(html);
      })
      //↓フォームの送信に失敗した場合の処理
      .fail(function() {
        alert('error');
      });
    });
  });
});
