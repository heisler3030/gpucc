Gpucc::Application.routes.draw do
  
# Authenticated users route to /today  
  authenticated :user do
    root 'todays_workout#index', as: nil
  end
  
  devise_for :users
  
  devise_scope :user do
    get "/"                   => "devise/sessions#new"
    delete "users/sign_out"   => "devise/sessions#destroy"
  end

# Unauthenticated users to login page
  root "devise/sessions#new"

  resources :challenges do
   resources :workouts, shallow: true do
      resources :workout_exercises, shallow: true 
    end
  end

  resources :exercises, :challenge_assignments, :completed_sets,
     :users, :completed_workouts, :applicants


  get '/today' => 'todays_workout#index'
  get '/home' => 'home#index'
  get '/about' => 'pages#about', as: "about"
  get '/terms' => 'pages#terms', as: "terms"
  get '/privacy' => 'pages#privacy', as: "privacy"
  get '/missedworkouts/:id' => 'missed_workouts#show', as: "missedworkouts"
  get '/workouts/:id/:user' => 'workouts#show', as: "userworkout"
  get '/challenges/:id/manageparticipants' => 'challenges#manage_participants', as: "manageparticipants"
  get '/challenges/:id(/:user)' => 'challenges#show'

end
