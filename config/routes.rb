Weber::Application.routes.draw do
  get '/' => 'reservations#index', as: :root

  controller :sessions do
    get :signin, action: :new
    post :signin, action: :create
    delete :signout, action: :destroy
  end

  resources :reservations, except: [:edit, :update, :destroy]

  namespace :admin do
    get '/' => 'dashboards#index', as: :admin_root

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
