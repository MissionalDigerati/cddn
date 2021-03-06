Cddn::Application.routes.draw do
  
  scope '/admin' do
    devise_for :admins
  end
  
  namespace 'admin'do 
    resources :users do
      member do
        put "suspend"
      end
    end
    resources :events do
      member do
        put "allow_event_posting"
      end
    end
    resources :projects do
      member do
        put "allow_project_posting"
      end
    end
  end
  
  match "/admin" => redirect("/admin/admins/sign_in")
  
  devise_for :users, :controllers => {:registrations => "registrations"}, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users do
    member do
      put "please_update"
      get "my_projects"
      get "my_events"
    end
  end
  resources :events do
    member do
      put "attend_event"
      # get "past_events"
    end
  end
  resources :projects do
    member do
      post "join_project_request", as: "join"
      delete "leave_project", as: "leave"
    end
  end
  resources :memberships do
    member do
      put "project_update_memberships", as: "project_update"
    end
  end
  resources :programming_languages do
  end
  match 'users/dashboard/:id' => 'users#dashboard', method: :get, as: :users_dashboard
  match 'event/past_events' => 'events#past_events', as: "past_events"

  match 'complete/licenses' => 'completes#licenses', as: "licenses_auto"
  match 'complete/languages' => 'completes#languages', as: "languages_auto"
  match 'complete/networks' => 'completes#networks', as: "networks_auto"

  authenticated :user do
    root :to => "users#dashboard"
  end
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
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
