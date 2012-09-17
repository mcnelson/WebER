Weber::Application.routes.draw do

  namespace :admin do
    resources :timeframes
  end
end
