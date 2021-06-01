Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    member do
      get :start
      get :complete
    end
  end

  get 'users/sign_up', to: 'registrations#new', as: 'registration'
  post '/users', to: 'registrations#create'
end
