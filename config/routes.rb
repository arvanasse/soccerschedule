Soccerschedule::Application.routes.draw do
  get "dashboard/show"

  resource :session
  resource :dashboard
  resources :teams
  resources :classifications
  resources :advertisements
  resources :team_followers

  resources :users do
    collection do
      get :guest
    end
  end

  resources :schedules
  match 'dashbaord' => 'dashboard#show'
  match '/' => 'team_followers#index'
end
