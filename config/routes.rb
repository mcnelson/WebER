Weber::Application.routes.draw do


  namespace :admin do
    resources :semesters
    resources :er_hours
    resources :users, controller: :user_infos

    resources :categories
    resources :equipment
  end
end
