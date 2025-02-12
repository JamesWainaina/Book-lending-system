Rails.application.routes.draw do
  # User authentication routes (Devise or default Rails auth)
  devise_for :users
  
  # Static home page
  root to: "home#index"
  
  # User profile
  get "users/profile", to: "users#profile"
  
  # Book routes with full CRUD actions (index, show, new, create, etc.)
  resources :books do
    member do
      post 'borrow'
      post 'return'
    end
  end

  # Health check
  get "up", to: "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
