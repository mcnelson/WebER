Weber::Application.routes.draw do


  namespace :admin do
    resources :semesters
    resources :er_hours
    resources :users, as: :user_infos, controller: :user_infos

    resources :categories
    resources :equipment
  end
end
