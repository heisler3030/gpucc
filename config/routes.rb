Gpucc::Application.routes.draw do
  authenticated :user do
    root :to => 'todays_workout#index'
  end

 # devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  
  devise_for :users
  
  devise_scope :user do
    get "/"                   => "devise/sessions#new"
    delete "users/sign_out"   => "devise/sessions#destroy"
  end


  #resources :users

  root :to => "devise/sessions#new"
 

  resources :challenges do
    resources :workouts, shallow: true do
      resources :workout_exercises, shallow: true 
    end
  end

  resources :exercises, :challenge_assignments, :completed_sets, :users

  match '/today' => 'todays_workout#index'

end