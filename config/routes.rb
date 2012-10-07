Weber::Application.routes.draw do
  root :to => "Admin::Reservations#new"

  controller :sessions do
    get :signin, action: :new
    post :signin, action: :create
    delete :signout, action: :destroy
  end

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
