Rails.application.routes.draw do
  resources :shows do
    match '/scrape', to: 'shows#scrape', via: :post, on: :collection
  end

  root to: 'shows#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
