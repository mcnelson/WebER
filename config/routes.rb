Weber::Application.routes.draw do

  resources :er_hours

  namespace :admin do
    resources :semesters
  end
end
