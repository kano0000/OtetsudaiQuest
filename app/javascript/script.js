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
