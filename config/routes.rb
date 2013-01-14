Weber::Application.routes.draw do
  root to: "Reservations#index"

  controller :sessions do
    get :signin, action: :new
    post :signin, action: :create
    delete :signout, action: :destroy
  end

  resources :reservations, except: [:edit, :update, :destroy]

  namespace :admin do
    root to: "Admin::Dashboards#index"

    controller :dashboards do
      get :index
    end

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
