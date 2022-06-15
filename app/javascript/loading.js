$(function () {
  const h = $(window).height();
  $("#loader-bg ,#loader").height(h).css("display", "block"); //ローディング画像を表示
});
$(window).on("turbolinks:load", function () {
  // 読み込み完了したら実行する
  $("#loader").delay(600).fadeOut(300); // ローディングをフェードアウト
  $("#loader-bg").delay(900).fadeOut(800); // 背景色をフェードアウト
});