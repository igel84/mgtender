InitialRelease::Application.routes.draw do
  get "tenders/new"

  get "tenders/index"

    resources :news

    resources :password_resets

    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    get "signup" => "users#new", :as => "signup"

    get "profile" => "users#edit", as: 'profile'
    get "company" => "companies#edit", as: 'company'

    resources :sessions

    get "secret" => "home#secret", :as => "secret"
        
    resources :users do
      member do
        get :activate
        get :photo_delete
      end
    end

    resources :companies do
      member do
        get :logo_delete
      end
    end    

    resources :homes do
    collection do
      get 'profile'
      get 'company'
      get 'about'
      get 'my_tenders'
      get 'parts'
      get 'tenders'
      get 'new_tender'
      get 'tender'
    end
    end

    resources :tenders do
      resources :tender_attachments
    end

    resources :tender_steps

    root :to => "homes#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
