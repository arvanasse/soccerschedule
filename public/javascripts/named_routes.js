var Routing = {

get_path: function(segments, options, overrides) {
  var extras = null;

  for (var property in overrides) {
    if (options[property] != null) {
      options[property] = overrides[property];
    }
    else {
      extras = extras ? extras : {};
      extras[property] = overrides[property]
    }
  }

  for (var prop in options) {
    // perform replace for optional props (e.g. 'format=json'):
    //  "/avatar/new(.:format)?" ==> "/avatar/new.json"
    segments = segments.replace(new RegExp("\\(([^:]*):" + prop + '\\)\\?'),(options[prop] ? '$1' : '') + options[prop])

    // perform standard replace for required props (e.g. 'id=1'):
    //  "/avatar/:id/edit" ==> "/avatar/1/edit"
    segments = segments.replace(":"+prop, options[prop]);
  }

  var query="";
  if (extras) {
    query += "?"
    for (var extra in extras) {
      query += extra + "=" + extras[extra] + "&";
    }
    query = query.substring(0, query.length-1);
  }

  var path = segments;
  while (path[path.length - 1] == "/") {
    path = path.substring(0, path.length - 1);
  }
  return path + query;
},

get_url: function(segments, options, overrides) {
  return Routing.host + Routing.get_path(segments, options, overrides);
},


new_classification_url: function(overrides) { return Routing.host + Routing.new_classification_path(overrides) },

new_classification_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/classifications/new(.:format)?", options, overrides);
},


new_dashboard_url: function(overrides) { return Routing.host + Routing.new_dashboard_path(overrides) },

new_dashboard_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/dashboard/new(.:format)?", options, overrides);
},


dashboard_url: function(overrides) { return Routing.host + Routing.dashboard_path(overrides) },

dashboard_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/dashboard(.:format)?", options, overrides);
},


session_url: function(overrides) { return Routing.host + Routing.session_path(overrides) },

session_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/session(.:format)?", options, overrides);
},


edit_user_url: function(overrides) { return Routing.host + Routing.edit_user_path(overrides) },

edit_user_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/users/:id/edit(.:format)?", options, overrides);
},


teams_url: function(overrides) { return Routing.host + Routing.teams_path(overrides) },

teams_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/teams(.:format)?", options, overrides);
},


rails_info_properties_url: function(overrides) { return Routing.host + Routing.rails_info_properties_path(overrides) },

rails_info_properties_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/rails/info/properties(.:format)?", options, overrides);
},


dashbaord_url: function(overrides) { return Routing.host + Routing.dashbaord_path(overrides) },

dashbaord_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/dashbaord(.:format)?", options, overrides);
},


schedules_url: function(overrides) { return Routing.host + Routing.schedules_path(overrides) },

schedules_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/schedules(.:format)?", options, overrides);
},


new_user_url: function(overrides) { return Routing.host + Routing.new_user_path(overrides) },

new_user_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/users/new(.:format)?", options, overrides);
},


advertisement_url: function(overrides) { return Routing.host + Routing.advertisement_path(overrides) },

advertisement_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/advertisements/:id(.:format)?", options, overrides);
},


schedule_url: function(overrides) { return Routing.host + Routing.schedule_path(overrides) },

schedule_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/schedules/:id(.:format)?", options, overrides);
},


edit_advertisement_url: function(overrides) { return Routing.host + Routing.edit_advertisement_path(overrides) },

edit_advertisement_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/advertisements/:id/edit(.:format)?", options, overrides);
},


classifications_url: function(overrides) { return Routing.host + Routing.classifications_path(overrides) },

classifications_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/classifications(.:format)?", options, overrides);
},


team_url: function(overrides) { return Routing.host + Routing.team_path(overrides) },

team_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/teams/:id(.:format)?", options, overrides);
},


edit_session_url: function(overrides) { return Routing.host + Routing.edit_session_path(overrides) },

edit_session_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/session/edit(.:format)?", options, overrides);
},


edit_schedule_url: function(overrides) { return Routing.host + Routing.edit_schedule_path(overrides) },

edit_schedule_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/schedules/:id/edit(.:format)?", options, overrides);
},


new_advertisement_url: function(overrides) { return Routing.host + Routing.new_advertisement_path(overrides) },

new_advertisement_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/advertisements/new(.:format)?", options, overrides);
},


edit_team_url: function(overrides) { return Routing.host + Routing.edit_team_path(overrides) },

edit_team_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/teams/:id/edit(.:format)?", options, overrides);
},


new_schedule_url: function(overrides) { return Routing.host + Routing.new_schedule_path(overrides) },

new_schedule_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/schedules/new(.:format)?", options, overrides);
},


advertisements_url: function(overrides) { return Routing.host + Routing.advertisements_path(overrides) },

advertisements_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/advertisements(.:format)?", options, overrides);
},


new_team_url: function(overrides) { return Routing.host + Routing.new_team_path(overrides) },

new_team_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/teams/new(.:format)?", options, overrides);
},


dashboard_show_url: function(overrides) { return Routing.host + Routing.dashboard_show_path(overrides) },

dashboard_show_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/dashboard/show(.:format)?", options, overrides);
},


guest_users_url: function(overrides) { return Routing.host + Routing.guest_users_path(overrides) },

guest_users_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/users/guest(.:format)?", options, overrides);
},


team_follower_url: function(overrides) { return Routing.host + Routing.team_follower_path(overrides) },

team_follower_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/team_followers/:id(.:format)?", options, overrides);
},


team_followers_url: function(overrides) { return Routing.host + Routing.team_followers_path(overrides) },

team_followers_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/team_followers(.:format)?", options, overrides);
},


user_url: function(overrides) { return Routing.host + Routing.user_path(overrides) },

user_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/users/:id(.:format)?", options, overrides);
},


edit_team_follower_url: function(overrides) { return Routing.host + Routing.edit_team_follower_path(overrides) },

edit_team_follower_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/team_followers/:id/edit(.:format)?", options, overrides);
},


classification_url: function(overrides) { return Routing.host + Routing.classification_path(overrides) },

classification_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/classifications/:id(.:format)?", options, overrides);
},


js_named_routes_url: function(overrides) { return Routing.host + Routing.js_named_routes_path(overrides) },

js_named_routes_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/js_named_routes(.:format)?", options, overrides);
},


users_url: function(overrides) { return Routing.host + Routing.users_path(overrides) },

users_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/users(.:format)?", options, overrides);
},


new_team_follower_url: function(overrides) { return Routing.host + Routing.new_team_follower_path(overrides) },

new_team_follower_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/team_followers/new(.:format)?", options, overrides);
},


edit_classification_url: function(overrides) { return Routing.host + Routing.edit_classification_path(overrides) },

edit_classification_path: function(overrides) {
  var options = {id: '', format: ''};
  return Routing.get_path("/classifications/:id/edit(.:format)?", options, overrides);
},


edit_dashboard_url: function(overrides) { return Routing.host + Routing.edit_dashboard_path(overrides) },

edit_dashboard_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/dashboard/edit(.:format)?", options, overrides);
},


new_session_url: function(overrides) { return Routing.host + Routing.new_session_path(overrides) },

new_session_path: function(overrides) {
  var options = {format: ''};
  return Routing.get_path("/session/new(.:format)?", options, overrides);
},


host: "http://soccerschedule.local"
};
