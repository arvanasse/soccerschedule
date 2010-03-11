// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  $('#save_schedule').click(function(){
    if( $(this).attr('checked') ){
      $('#credentials').slideDown();
    } else {
      $('#credentials').slideUp();
    }
  });
});
