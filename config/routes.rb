Greasyfork::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

	# disable destroying users
	devise_for :users, :skip => :registrations, :controllers => { :sessions => "sessions" }
		devise_scope :user do
		resource :registration,
		only: [:new, :create, :edit, :update],
		path: 'users',
		path_names: { new: 'sign_up' },
		controller: :registrations,
		as: :user_registration do
			get :cancel
		end
	end
	devise_scope :user do 
		# a GET path for logging out for use with the forum
		get '/users/sign_out' => 'sessions#destroy'
	end
  
	root :to => "home#index"

	resources :scripts, :only => [:index, :show] do
		# Deprecated after https://github.com/JasonBarnabe/greasyfork/issues/76
		get 'code.meta.js', :to => 'scripts#meta_js'
		get 'code.user.js', :to => 'scripts#user_js'

		get 'code/:name.user.js', :to => 'scripts#user_js', :as =>  'user_js'
		get 'code/:name.js', :to => 'scripts#user_js', :as =>  'library_js'
		get 'code/:name.meta.js', :to => 'scripts#meta_js', :as =>  'meta_js'
		get 'code(.:format)', :to => 'scripts#show_code', :as =>  'show_code'
		get 'feedback(.:format)', :to => 'scripts#feedback', :as =>  'feedback'
		get 'sync(.:format)', :to => 'scripts#sync', :as =>  'sync'
		patch 'sync_update(.:format)', :to => 'scripts#sync_update', :as =>  'sync_update'
		post 'install-ping', :to => 'scripts#install_ping', :as => 'install_ping'
		get 'diff', :to => 'scripts#diff', :as => 'diff', :constraints => lambda{ |req| !req.params[:v1].blank? and !req.params[:v2].blank? }
		get 'moderator-delete(.:format)', :to => 'scripts#moderator_delete', :as => 'moderator_delete'
		post 'moderator-delete(.:format)', :to => 'scripts#moderator_do_delete', :as => 'moderator_do_delete'
		post 'moderator-undelete(.:format)', :to => 'scripts#moderator_do_undelete', :as => 'moderator_do_undelete'
		collection do
			get 'by-site(.:format)', :action => 'by_site', :as => 'site_list'
			get 'by-site/:site(.:format)', :action => 'index', :as => 'by_site', :constraints => {:site => /.*/}
			get 'under-assessment(.:format)', :action => 'under_assessment', :as => 'under_assessment'
			get 'reported(.:format)', :action => 'reported', :as => 'reported'
			get 'libraries(.:format)', :action => 'libraries', :as => 'libraries'
			get 'search(.:format)', :action => 'search', :as => 'search'
		end
		resources :script_versions, :only => [:create, :new, :show, :index], :path => 'versions'
	end
	resources :script_versions, :only => [:create, :new]
	resources :users, :only => :show

	get 'import', :to => 'import#index', :as => 'import_start'
	get 'import/userscriptsorg', :to => 'import#userscriptsorg', :as => 'import_userscriptsorg'
	post 'import/verify', :to => 'import#verify', :as => 'import_verify'
	post 'import/add', :to => 'import#add', :as => 'import_add'
	get 'import/url', :to => 'import#url', :as => 'import_url'

	get 'help', :to => 'help#index', :as => 'help'
	get 'help/allowed-markup', :to => 'help#allowed_markup', :as => 'help_allowed_markup'
	get 'help/code-rules', :to => 'help#code_rules', :as => 'help_code_rules'
	get 'help/contact', :to => 'help#contact', :as => 'help_contact'
	get 'help/credits', :to => 'help#credits', :as => 'help_credits'
	get 'help/disallowed-code', :to => 'help#disallowed_code', :as => 'help_disallowed_code'
	get 'help/installing-user-scripts', :to => 'help#installing_user_scripts', :as => 'help_installing_user_scripts'
	get 'help/rewriting', :to => 'help#rewriting', :as => 'help_rewriting'

	post 'preview-markup', :to => 'home#preview_markup', :as => 'preview_markup'

	resources :moderator_actions, :only => [:index]

	get 'sso', :to => 'home#sso'

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
