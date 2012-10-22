Weber::Application.routes.draw do
  root :to => "Dashboards#index"

  controller :sessions do
    get :signin, action: :new
    post :signin, action: :create
    delete :signout, action: :destroy
  end

  controller :dashboards do
    get :index
  end

  namespace :admin do
    resources :semesters do
      resources :er_hours, except: :index
    end

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
