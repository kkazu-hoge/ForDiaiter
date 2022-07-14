$(document).bind("ajaxComplete turbolinks:load",function(){
  //タブ//
  $('#tab-contents .tab[id != "tab1"]').hide();

  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
  //タブ//

  //スクロールアイコン//
  $(function(){
    var topBtn=$('#page_top');
    topBtn.hide();

    //ボタンの表示設定
    $(window).scroll(function(){
      if($(this).scrollTop()>80){
        // 画面を80pxスクロールしたら、ボタンを表示する
        topBtn.fadeIn();
      }else{
        // 画面が80pxより上なら、ボタンを表示しない
        topBtn.fadeOut();
      }
    });

    // ボタンをクリックしたら、スクロールして上に戻る
    topBtn.click(function(){
      $('body,html').animate({
      scrollTop: 0},500);
      return false;
    });

  });
  //スクロールアイコン//
});
