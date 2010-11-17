// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Hook the rel='facebox' in order to wire up facebox
$('a[rel*=facebox]').livequery(function() {
    $(this).facebox();
});


