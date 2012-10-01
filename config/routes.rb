Weber::Application.routes.draw do

  namespace :admin do
    resources :semesters
    resources :er_hours
    resources :users

    resources :categories
    resources :equipment

    resources :reservations do
      collection do
        get :autocomplete_user_punet
        get :autocomplete_equipment_name
      end
    end

    resources :packages
  end
end
