Weber::Application.routes.draw do
  get '/' => 'reservations#index', as: :root

  controller :sessions do
    get :signin, action: :new
    post :signin, action: :create
    delete :signout, action: :destroy
  end

  resources :reservations, except: %w(edit update destroy)

  controller :units do
    get :forty_image, as: :unit_forty_image
  end

  namespace :admin do
    get '/' => 'reservations#index', as: :admin_root

    resources :semesters do
      resources :er_hours, except: [:index, :show]
    end

    resources :users, except: [:delete, :show]

    resources :categories, only: [:index, :destroy]
    resources :equipment_categories, only: [:create, :edit, :update]
    resources :accessory_categories, only: [:create, :edit, :update]

    resources :equipment
    resources :accessories, except: :index

    resources :reservations
    resources :packages
  end
end
