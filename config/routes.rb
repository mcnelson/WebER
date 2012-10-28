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

  get "ajax/reservation_tabbox"

  namespace :admin do
    #root to: "Dashboards#admin_index"

    resources :semesters do
      resources :er_hours, except: [:index, :show]
    end

    resources :users

    resources :categories
    resources :equipment

    resources :reservations
    resources :packages
  end
end
