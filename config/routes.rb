ActionController::Routing::Routes.draw do |map|
  map.resource  :session
  map.resources :teams
  map.resources :team_followers, :only =>[ :index, :create ]
  map.resources :users, :collection=>{ :guest => :get }

  map.resources :schedules, :only => :index

  map.root :controller => :schedules, :action=>:index
end
