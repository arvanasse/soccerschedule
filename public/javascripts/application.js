$(document).ready(function(){
  $('#save_schedule').click(function(){
    if( $(this).attr('checked') ){
      $('#credentials').slideDown();
    } else {
      $('#credentials').slideUp();
    }
  });

  $('#show-login').click(function(){
    $('#show-login').hide();
    $('#login-form').slideToggle();
    return false;
  });
});

  $('a[rel*=facebox]').livequery(function() {
      $(this).facebox();
  });

