Rails.application.routes.draw do
  get 'inventries/index'
  # get 'sales/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "items#index"
  resources :items, only: [:index,:new,:create,:destroy]
  resources :sales,only:[:index,:new,:create] do
    collection do
      get 'edit_sales'
      # post 'update_sales'
    end
  end
  resources :inventries, only:[:index,:new,:create]
  
end
