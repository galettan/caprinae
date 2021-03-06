Rails.application.routes.draw do

  resources :lists
  resources :various_stocks
  resources :paperstocks
  resources :events
  resources :projects
  resources :clients
  resources :activities
  get 'sessions/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :users

  root to: "sessions#new"
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'clients/:id/action' => 'clients#action'
  post 'clients/:id/deactivate' => 'clients#deactivate'
  post 'clients/:id/activate' => 'clients#activate'

  get '/projects/:id/clone' => 'projects#clone', as: :clone_project
  get 'projects/:id/delivery_form' => 'projects#delivery_form', as: :delivery_form

  get '/activities' => 'activities#index'
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
