Weber::Application.routes.draw do

  namespace :admin do
    resources :semesters
  end
end
