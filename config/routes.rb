Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    member do
      get :start
      get :complete
    end
  end
  
  resource :users, controller: 'registrations', only: [:create, :edit, :update] do
    get '/sign_up', action: 'new'
  end

  get 'users/sign_in', to: 'sessions#new', as: 'session'
  post '/login', to: 'sessions#create', as: 'login'
  get 'user/sign_out', to: 'sessions#destroy', as: 'logout'
end
