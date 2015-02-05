
$(function () {
  $('.compare-link').click(function () {
    $('.diagram').fadeOut(500);
    $('.compare-prints').fadeIn(500);
  })
  $('.diagram-link').click(function () {
    $('.compare-prints').fadeOut(500);
    $('.diagram').fadeIn(500);
  })
});
