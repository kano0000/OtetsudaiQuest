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
$(document).on('turbolinks:load', function() {
  $("#splash-logo").delay(1200).fadeOut('slow');
  $("#splash").delay(1800).fadeOut('slow',function(){
      $('.game-page').addClass('appear');
  });
});

//complete_page
function createLines() {
  let line = document.createElement("div");
  line.setAttribute("class", "line");

  // complete_bg クラスを持つ要素にだけ光を追加
  let completeBgElement = document.querySelector(".complete_bg");
  if (completeBgElement) {
    completeBgElement.appendChild(line);

    line.style.left = Math.random() * innerWidth + "px";
    line.style.animationDuration = 1 + Math.random() * 12 + "s";
    line.style.width = Math.random() * 12 + "px";
    line.style.height = Math.random() * 12 + "px";

    // 光を消すまでの時間
    setTimeout(function () {
      completeBgElement.removeChild(line);
    }, 3000);
  }
}

// 光を繰り返し発射する
setInterval(function () {
  createLines();
}, 200);

// フラッシュメッセージ
$(function(){
  setTimeout("$('.notice').fadeOut('slow')", 1500);
});

$(function(){
  setTimeout("$('.alert').fadeOut('slow')", 1500);
});

// 写真アップロード時のプレビュー画面
if (document.URL.match(/new/)){
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img'); 
      blobImage.setAttribute('class', 'new-img') 
      blobImage.setAttribute('src', blob); 
      imageElement.appendChild(blobImage);
    };

    document.getElementById('task_quest_image').addEventListener('change', (e) => {
      const imageContent = document.querySelector('.new-img'); 
      if (imageContent){ 
        imageContent.remove(); 
      } 
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}