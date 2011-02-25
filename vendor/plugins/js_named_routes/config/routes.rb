Rails.application.routes.draw do |map|
  match '/js_named_routes' => 'named_routes#generate', :method => :get
end
