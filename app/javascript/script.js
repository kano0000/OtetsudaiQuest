// スクロール
$(document).on('turbolinks:load', function() {
  var scrollButton = $('#scrollButton');

  toggleScrollButtonVisibility();

  $(window).on('scroll', function() {
    toggleScrollButtonVisibility();
  });

  scrollButton.on('click', function(event) {
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    event.preventDefault();
  });

  function toggleScrollButtonVisibility() {
    if ($(window).scrollTop() > 250) {
      scrollButton.fadeIn();
    } else {
      scrollButton.fadeOut();
    }
  }
});


// 画面遷移アニメーション
$(window).on('load',function() {
    $("#splash-logo").delay(1200).fadeOut('slow');
    $("#splash").delay(1800).fadeOut('slow',function(){
        $('.game-page').addClass('appear');
    });
});
