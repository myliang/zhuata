Zhuata::Application.routes.draw do

  # match "/logout" => "devise/sessions#destroy"

  # The priority is based upon order of creation:
  # first created -> highest priority.
  devise_for :users, :controllers => {:sessions => "devise/sessions", :registrations => "registrations"} do
    get "sign_in", :to => "devise/sessions#new", :as => :sign_in
    get "sign_up", :to => "registrations#new", :as => :sign_up
    get "sign_out", :to => "devise/sessions#destroy", :as => :sign_out
    get "users/edit_pwd", :to => "registrations#edit_pwd", :as => :edit_pwd
    get "users/edit_avatar", :to => "registrations#edit_avatar", :as => :edit_avatar
    put "users/update_pwd", :to => "registrations#update_pwd", :as => :update_pwd
    put "users/update_avatar", :to => "registrations#update_avatar", :as => :update_avatar
  end

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :compares, :fictions, :pictures, :blogs do
    resources :comments, only: [:index]
  end

  resources :comments
  resources :messages do
    collection do
      get 'to'
      get 'from'
    end
  end

  # match paginate url
  match 'blogs/tag/:tags' => 'blogs#tag', :as => :tag_blogs
  match ":user_id" => "blogs#index"
  match ":user_id/blogs" => "blogs#index", :as => :user_blogs
  match ":user_id/compares" => "compares#index", :as => :user_compares
  match ":user_id/fictions" => "fictions#index", :as => :user_fictions
  match ":user_id/pictures" => "pictures#index", :as => :user_pictures
  match ":user_id/messages/from" => "messages#from"
  match ":user_id/messages/to" => "messages#to"

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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
