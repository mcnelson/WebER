Weber::Application.routes.draw do

  namespace :admin do
    resources :semesters
    resources :er_hours
    resources :users

    resources :categories
    resources :equipment
    resources :reservations
  end
end
