Rails.application.routes.draw do
  devise_for :users
  root 'admin/users#index'
 
  resources :users
  resources :bid_logs
  namespace :admin do
    resources :users do
      get 'delete_avatar'
      get 'list_team_players'
      post 'close_bid'
    end

    resources :matches do
      collection do
        get 'points_table'
      end
    end

    resources :innings do
      get 'start_innings'
      post 'proceed_innings'
      post 'create_ball_details'
      post 'create_over'
      get 'switch_strike'
      get 'scoreboard'
    end
  end
  namespace :team_owner do
    resources :users do
      get 'list_team_players'
      get 'delete_avatar'
    end
  end

  mount ActionCable.server => '/cable'
  # The priority is based upon order of creation: first created  > highest priority.
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

  # Example resource route with sub resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub resources:
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
