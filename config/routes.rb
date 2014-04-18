Rails.application.routes.draw do
  get 'users/shifts'

  devise_for :users

  root 'notifications#index'
  resources :notifications, only: [ :index, :destroy ] do
    member do
      post :add_shift
      post :trade_shift
      post :take_shift
    end
  end

  get 'user_shifts', to: 'user_shifts#index'
  post 'user_shifts/update_selections'
  get 'admin/shifts', to: 'admin/shifts#index'
  post 'admin/shifts/generate_schedule'
  post 'admin/shifts/publish_schedule'
  post 'admin/shifts/unpublish_schedule'

  post 'shift_changes_request/create_cover_request'
  post 'shift_changes_request/accept_cover_request'
  post 'shift_changes_request/decline_cover_request'


  get '/my_schedule', to: 'shift_change_requests#user_schedule'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
