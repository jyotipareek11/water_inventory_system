WaterInventorySystem::Application.routes.draw do
  
 

  resources :invoices

  resources :orders

  resources :reports do
    collection do 
      get 'monthly_invoicing'
      post 'invoice_report'
      post 'invoice_report_to_pdf'
      get 'monthly_inventory'
      post 'inventory_report'
    end
  end  

  resources :sales do
    member do
      get 'update_state'
    end 
  end    

  resources :inventories, only: [:index]

  resources :products do 
    member do
      get 'available_quantity_in_inventory'
    end
  end  

  resources :purchases do
    member do
      get 'update_state'
    end 
    collection do
      get 'orders_from_distributors'
    end 
  end  

  resources :vendors #do
    # resources :purchase_orders
    
  # end  

  resources :clients

  resources :locations do
    resources :distributors#, only: [:index,:new,:create]
  end 
  #resources :distributors, only: [:show,:edit,:update,:destroy]
  # resources :posts do
  #   resources :comments, only: [:index, :new, :create]
  # end
  # resources :comments, only: [:show, :edit, :update, :destroy]
  # get 'distributors/new', to: 'users/sign_up'


  get 'select', to: 'distributors#select'
  post 'location', to: 'distributors#location'
  
  devise_for :users
  root 'home#index'

  # get 'distributors' =>'users/distributors'
  get 'distributors', to: 'users#distributors'
  # get 'clients', to: 'users#clients'
  # get 'users/show/:id/', to: 'users#show'

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
