Gpucc::Application.routes.draw do
  
# Authenticated users route to /today  
  authenticated :user do
    root :to => 'todays_workout#index'
  end
  
  devise_for :users
  
  devise_scope :user do
    get "/"                   => "devise/sessions#new"
    delete "users/sign_out"   => "devise/sessions#destroy"
  end

# Unauthenticated users to login page
  root :to => "devise/sessions#new"
 

  resources :challenges do
    resources :workouts, shallow: true do
      resources :workout_exercises, shallow: true 
    end
  end

  resources :exercises, :challenge_assignments, :completed_sets, :users, :completed_workouts


  match '/today' => 'todays_workout#index'
  match '/home' => 'home#index'
  match '/missedworkouts/:id' => 'missed_workouts#show', :as => "missedworkouts"
  match '/workouts/:id/:user' => 'workouts#show', as: "userworkout"

end