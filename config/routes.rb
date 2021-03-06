Rails.application.routes.draw do

root "static_pages#home"
  scope "(:locale)", locale: /en|vi/ do
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    resources :users
    get "/signup", to: "users#new"
    post "/signup", to: "user#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
        member do
            get :following, :followers
        end
    end
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]
    get "sessions/new"
  end
end
