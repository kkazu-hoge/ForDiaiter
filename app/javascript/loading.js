// 即時関数
(function () {
  const h = $(window).height();
  $("#loader-bg ,#loader").height(h).css("display", "block"); //ローディング画像を表示
});
// 関連データの全ての読み込みが完了したら実行
$(window).on("turbolinks:load", function () {
  $("#loader").delay(600).fadeOut(300); // ローディングをフェードアウト
  $("#loader-bg").delay(900).fadeOut(800); // 背景色をフェードアウト
});