Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    get "help" => "static_pages#help"
    get "about" => "static_pages#about"
    get "contact" => "static_pages#contact"
  resource: users
    get "signup" => "users#new"
    root "static_pages#home"
  end
end
