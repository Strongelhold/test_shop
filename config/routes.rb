Rails.application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]
  resources :products do
    get :buy, on: :member
  end
  resources :admins
  resources :guests
  resources :shop_owners
  resources :users do
    get :change_type, on: :member
  end

  match '/adminsignup',         to: 'admins#new',       via: 'get'
  match '/guestsignup',         to: 'guests#new',       via: 'get'
  match '/shopownersignup',     to: 'shop_owners#new',  via: 'get'
  match '/signin',              to: 'sessions#new',     via: 'get'
  match '/signout',             to: 'sessions#destroy', via: 'delete'

  #get '/products/:id/buy_product' => 'products#buy_product', as: :buy_product
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
