Weber::Application.routes.draw do
  root to: "Dashboards#index"

  controller :sessions do
    get :signin, action: :new
    post :signin, action: :create
    delete :signout, action: :destroy
  end

  controller :dashboards do
    get :index
  end

  resources :reservations

  namespace :admin do
    #root to: "Dashboards#admin_index"

    resources :semesters do
      resources :er_hours, except: [:index, :show]
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
