Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "public#index"
  get "tours", to: "public#tours", as: "tours"
  get "tours/:id", to: "public#tour", as: "tour"
  get "tours/:tour_id/bookings/new", to: "public#new", as: "new_tour_booking"
  post "tours/:tour_id/bookings", to: "public#create", as: "tour_bookings"
  namespace :admin do
    resources :categories, except: [ :show ] do
      member do
        get :confirm_destroy
      end
    end
    resources :tours do
      member do
        get :confirm_destroy
      end
    end
    resources :bookings do
      member do
        get :confirm_destroy
      end
    end
  end

  get "admin", to: "admin#index", as: "admin"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
