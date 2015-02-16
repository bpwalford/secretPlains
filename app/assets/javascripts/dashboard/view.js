var Dashboard = {
  collapseSearch: function () {
    $('.form').fadeOut(300);
    $('.compare-prints').delay(400).animate({
      width:50,
      height:50,
      padding:0,
      'margin-left':'86px',
      'margin-top':'-43px',
    }, 800);
    $('.search-icon').delay(700).fadeIn(300);
  },
  inflateSearch: function () {
    $('.compare-prints').animate({
      width:'40%',
      height:375,
      padding:'0% 3%',
      'margin-top':'10vh',
      'margin-left':'30%',
    }, 800);
    $('.search-icon').fadeOut(400);
    $('.form').delay(700).fadeIn(300);
  }
}


$(function () {
  // when in compare view and changing to diagram
  $('.diagram-link, .exit-comparison').click(function () {
    Dashboard.collapseSearch();
    $('.results').fadeOut(300);
    $('.diagram').delay(500).fadeIn(500);
  });

  // when seach button is clicked, i.e. results are displayed
  $('.compare').on('click', '.btn-lg', function () {
    Dashboard.collapseSearch();
    $('#spinner').delay(500).fadeIn(200);
  });

  // starting a new seach when in search view
  $('.compare-prints').on('click', '.search-icon', function () {
    $('.diagram').fadeOut(300);
    $('.results').fadeOut(300).html('');
    Dashboard.inflateSearch();
  });
});
