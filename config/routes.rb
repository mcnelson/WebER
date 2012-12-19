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

  controller :ajax do
    get :reservation_tabbox
    get "ajax/reservation/:reservation_id/status", action: :check_unit_availability, as: :check_unit_availability
    get :equipment_dependencies
  end

  namespace :admin do
    #root to: "Dashboards#admin_index"

    resources :semesters do
      resources :er_hours, except: [:index, :show]
    end

    resources :users

    resources :categories, only: [:index, :destroy]
    resources :equipment_categories, only: [:create, :edit, :update]
    resources :accessory_categories, only: [:create, :edit, :update]

    resources :equipment
    resources :accessories, except: :index

    resources :reservations
    resources :packages
  end
end
