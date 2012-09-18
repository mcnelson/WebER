Weber::Application.routes.draw do

  namespace :admin do
    resources :semesters
    resources :er_hours
  end
end
