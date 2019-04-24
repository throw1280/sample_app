Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    resources :static_pages
    get "help" => "static_pages#help"
    get "about" => "static_pages#about"
    get "contact" => "static_pages#contact"
    root "static_pages#home"
  end
end
