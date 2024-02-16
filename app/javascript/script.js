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

//exchange_page
function createLines() {
  let line = document.createElement("div");
  line.setAttribute("class", "line");

  // exchange_bg クラスを持つ要素にだけ光を追加
  let completeBgElement = document.querySelector(".complete_bg");
  if (completeBgElement) {
    completeBgElement.appendChild(line);

    line.style.left = Math.random() * innerWidth + "px";
    line.style.animationDuration = 3 + Math.random() * 12 + "s";
    line.style.width = Math.random() * 12 + "px";
    line.style.height = Math.random() * 12 + "px";

    // 光を消すまでの時間
    setTimeout(function () {
      completeBgElement.removeChild(line);
    }, 6000);
  }
}

// 光を繰り返し発射する
setInterval(function () {
  createLines();
}, 400);