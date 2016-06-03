Rails.application.routes.draw do
  get 'sign_up/create'

  devise_for :users, controller: { sessions: 'sign_up' }
  as :user do
    get 'users/edit', to: 'devise/registrations#edit', as: :edit_user_registration
    put 'users', to: 'devise/registrations#update', as: :user_registration     
    get 'users/create', to: 'devise/sessions#create_user', as: :create_user_session 
    post 'users/create', to: 'sign_up#create_user', as: :create_user_post
  end

  root 'participants#welcome'

  get  'faye_test', to: 'faye#test', as: :faye_test
  post 'faye_test', to: 'faye#test'

  resources :buses, only: %i(create index destroy)

  resources :circle_check_scores, only: %i(create index update)

  resources :maneuvers, only: :index do
    member do
      get :next_participant
      get :previous_participant
    end
  end

  resources :maneuver_participants, except: %i(destroy edit index)

  resources :onboard_judgings, except: %i(destroy edit index) do
    collection do
      get :select_participant
    end
  end

  resources :participants, except: %i(edit new show) do
    collection do
      post :assign_number
      get :scoreboard
      get :scoreboard_partial
      get :welcome
    end
  end

  resources :quiz_scores, only: %i(create index update)
end
