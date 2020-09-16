Rails.application.routes.draw do
  get 'inventries/index'
  # get 'sales/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "items#index"
  resources :items, only: [:index,:new,:create,:edit,:update,:destroy]
  resources :sales,only:[:index,:new,:create,:edit,:update] 
  resources :inventories, only:[:index,:new,:create,:edit,:update] 
  resources :deliveries,only:[:index,:new,:create,:edit,:update] do
    collection do
      post 'special'
    end
  end
  resources :comments,only:[:new,:create]
  get 'comments/:id', to: 'comments#checked'
  get 'comments/:id/destroy', to: 'comments#destroy'
end
