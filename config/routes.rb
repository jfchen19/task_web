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

  resource :users, controller: 'sessions', only: [] do
    get '/sign_in', action: 'new'
    post 'sign_in', action: 'create'
    delete 'sign_out', action: 'destroy'
  end
end
