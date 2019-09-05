Rails.application.routes.draw do

  root "home#index"

  get "/signup", to: "home#signup"
  post "/signup", to: "home#create"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/auth/facebook/callback", to: "sessions#create"
  get "/auth/failure", to: "home#index"
  delete "/logout", to: "sessions#destroy"

  resources :employees, only: [:show, :edit, :update] do
    member do
      put "approve"
      put "reject"
      put "notification_visible"
    end
    resources :notifications, only: [:index]
    resources :messages, only: [:new, :create, :index]
  end

  resources :chefs, only: [:show, :edit, :update] do
    member do
      put "approve"
      put "reject"
      put "notification_visible"
    end
    resources :notifications, only: [:index]
    resources :messages, only: [:new, :create, :index]
  end

  namespace :admins do
    root "home#index"

    get "approval/employee_approve"
    get "approval/chef_approve"

    get "visible/employee_order_notification"
    get "visible/chef_order_notification"
  end

  resources :statuses, except: [:show]

  resources :companies, except: [:show]

  resources :categories
  
  resources :food_stores do
    resources :food_galleries, only: [:new, :create]
  end

  resources :foods

  resources :carts, only: [:edit, :update, :show, :destroy] do
    member do
      get "checkout"
    end

    collection do
      get "history"
      get "recieved"
      get "pending"
    end
  end

  resources :cart_items, except: [:show]

  mount ActionCable.server => "/cable"

end
