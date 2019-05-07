Rails.application.routes.draw do

  get 'users/new'
  scope "(:locale)", locale: /en|vi/ do
    get "help" => "static_pages#help"
    get "about" => "static_pages#about"
    get "contact" => "static_pages#contact"
    resources :users
    get "signup" => "users#new"
    root "static_pages#home"
  end
end
