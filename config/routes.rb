Rails.application.routes.draw do
  
  devise_scope :user do
    namespace :users do
      get ':id/settings', to: 'static_pages#settings'
    end
  end

  devise_for  :users,
              :path => '',
              :path_names => {:sign_in => 'sign-in', :sign_out => 'sign-out', :sign_up => 'register' },
              controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  #Custom routes used by devise
  #http://stackoverflow.com/questions/3827011/devise-custom-routes-and-login-pages
  devise_for :admins, :path => 'admin'
  
  resources :users, only: [:show]
  resources :subscriptions
  resources :cards
  
  resources :machines, only: [:index, :show]
  

  #http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Scoping.html
  namespace "admin" do
    resources :parts, :except => [:new]
    resources :air_filters, :path => "airfilter", :as => "airfilter"
    resources :machines
    resources :atvs, :path => "atv", :as => "atv"
    resources :motorcycles, :path => "motorcycle", :as => "motorcycle"
    resources :snowmobiles, :path => "snowmobile", :as => "snowmobile"
  end
  
  #Sets route for typeahead.js remote query. Generates a JSON response
  get 'machines/queries/:search' => "machines#queries"
  #Links the Stripe cancel subscription button to the correct action
  get "subscriptions/destroy" => "subscriptions#destroy"

  
  post "subscriptions/webhook"

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: 'machines#index'
  


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
