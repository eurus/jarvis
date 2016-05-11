Rails.application.routes.draw do

  resource :wechat, only: [:show, :create]
  root 'dashboard#index'

  mount RuCaptcha::Engine => "/rucaptcha"

  resources :overtimes
  resources :feedbacks
  resources :weeklies
  resources :articals
  resources :projects do
    member do
      post 'create_log', as: 'create_log'
    end
  end
  resources :vacations
  resources :errands
  resources :plans do
    collection do
      get 'update_status'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get "settings" => "dashboard#setting"
  get "dashboard/weather" => "dashboard#weather"
  put "update_setting" => "dashboard#update_setting"

  # supervise actions
  get 'supervise/index'
  get 'supervise/bughunter'
  get 'supervise/bughunter/:id', to: 'supervise#bughunter_show',as: 'bugshow'
  get 'supervise/users' => 'supervise#users'
  get 'supervise/projects' => 'supervise#projects'
  get 'supervise/overtimes' => 'supervise#overtimes'
  get 'supervise/vacations' => 'supervise#vacations'
  get 'supervise/errands' => 'supervise#errands'
  get 'supervise/groups' => 'supervise#groups'

  get 'jarvis/checkontime' => 'dashboard#check_on_time'
  get 'jarvis/send' => 'dashboard#send_to_all'
  # supervise users
  get 'supervise/users/new' => "supervise#new_user"
  get 'supervise/users/edit/:id' => "supervise#edit_user"
  put 'supervise/users/:id' => "supervise#update_user"
  post 'supervise/users' => "supervise#create_user"
  delete 'supervise/users/:id' => 'supervise#destroy_user'

  # supervise projects
  get 'supervise/projects/new' => "supervise#new_project"
  get 'supervise/projects/edit/:id' => "supervise#edit_project", as: 'supervise_edit_project'
  put 'supervise/projects/:id' => "supervise#update_project"
  post 'supervise/projects' => "supervise#create_project"
  delete 'supervise/projects/:id' => 'supervise#destroy_project', as: 'supervise_destroy_project'
  get 'supervise/projects/done' => "supervise#done_project", as: 'supervise_done_project'

  get 'supervise/projects/:id' => "supervise#show_project", as: 'supervise_show_project'
  post 'supervise/projects/:id/logs' => "supervise#create_project_log", as: 'supervise_create_project_logs'
  delete 'supervise/logs/:id' => "supervise#destroy_project_log", as: 'supervise_destroy_project_logs'

  get 'supervise/group/new' => 'supervise#user_group_new'
  put 'supervise/groups' => 'supervise#user_group_update', as: 'supervise_group_update'
  get 'supervise/group/edit/:id' => 'supervise#user_group_edit', as: "edit_user_group"
  post 'supervise/group/create' => 'supervise#user_group_create'
  delete 'supervise/group/cancel/:id' => 'supervise#user_group_cancel', as: 'cancel_group'

  get 'checkrecord/:id' => 'supervise#check_record_by_type',as: 'checkrecord'
  get 'issuerecord/:id' => 'supervise#issue_record_by_type',as: 'issuerecord'

  scope :jarvis do
    post 'bughunter' => 'jarviscore#bughunter'
  end
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
