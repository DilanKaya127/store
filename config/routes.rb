Rails.application.routes.draw do
  get "home/index"
  resources :users, only: [ :new, :create ]
  resource :session, only: [ :new, :create, :destroy ]
  resource :unsubscribe, only: [ :show ]
  resources :passwords, param: :token

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    resources :subscribers, only: [ :create ]
  end
  resources :categories, only: [ :index, :show ]

  resources :carts do
    resources :cart_items, only: [ :create, :update, :destroy, :edit ]
    member do
      post "checkout"
    end
  end
  # Bu yapı şu URL’yi üretir: POST /carts/:id/checkout
  # Bu yapı /carts/:cart_id/cart_items/:id gibi yollar üretir

  get "/my_products", to: "products#my_products", as: :my_products
  get "/profile", to: "users#show", as: :profile

  root "home#index"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
