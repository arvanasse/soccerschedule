Soccerschedule::Application.routes.draw do
  resource :session
  resources :teams
  resources :advertisements
  resources :team_followers

  resources :users do
    collection do
      get :guest
    end
  end

  resources :schedules
  match '/' => 'schedules#index'
end
