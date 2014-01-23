Gpucc::Application.routes.draw do
  authenticated :user do
    root :to => 'todays_workout#index'
  end
  
  root :to => "splash#index"
  devise_for :users
  resources :users
  
  resources :challenges do
    resources :workouts, shallow: true do
      resources :workout_exercises, shallow: true 
    end
  end

  resources :exercises, :challenge_assignments, :completed_sets

  match '/today' => 'todays_workout#index'

end