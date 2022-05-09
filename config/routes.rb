Rails.application.routes.draw do

  # 会員
  # URLに"public"を含ませたくないためURLとファイル構成(public配下)が異なるscope moduleでルーティング定義
  scope module: 'public' do

    root :to =>'homes#top'
    get   "/home"     =>'homes#home'
    post  "/pj_alter" =>'homes#pj_alter'

    devise_for :customers,skip: [:passwords], controllers: {
      registrations: 'public/registrations'
    }

    get "customers/mypage"=>'customers#show'
    resources :customers, only: [:edit, :update] do
      get   :edit_mail_address,     on: :member
      get   :edit_password,         on: :member
      get   :edit_physical_info,    on: :member
      patch :update_mail_address,   on: :member
      patch :update_password,       on: :member
      patch :update_physical_info,  on: :member
      get   :unsubscribe,           on: :member
      get   :unsubscribe,           on: :member
      patch :defection,             on: :member
    end

    resources :projects,  only: [:index, :show, :new, :edit, :create, :update]
    resources :pj_events, only: [:show, :new, :edit, :update, :destroy]

    resources :pj_template_events, only: [:new, :create, :destroy] do
      get :pj_event_add_training, on: :collection
      get :show_event,            on: :collection
    end

    resources :callenders,  only: [:show, :new, :edit]
    resources :records,     only: [:index, :show]
    resources :trainings,   only: [:index, :show]

    resources :search_gyms, only: [:index] do
      post :search, on: :collection
    end

    resources :columns, only: [:index, :show]

  end


  #管理者
  # URLに"admin"にが含まれて問題ないためnamespaceでURLとファイル構成を同じように定義
  devise_for :admin, skip: [:passwords], controllers: {
    sessions: "admin/sessions",
    registrations: "admin/registrations"
  }

  namespace :admin do

    root :to =>'homes#home'
    resources :customerss,  only: [:index, :edit, :update]
    resources :columns,     only: [:index, :edit, :update]
    resources :trainings,   only: [:index, :edit, :create, :update, :destroy]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

########################################
########### ルーティング一覧############
########################################

#<会員(customer)>

#           new_customer_session GET    /customers/sign_in(.:format)                    public/sessions#new
#               customer_session POST   /customers/sign_in(.:format)                    public/sessions#create
#       destroy_customer_session DELETE /customers/sign_out(.:format)                   public/sessions#destroy
#   cancel_customer_registration GET    /customers/cancel(.:format)                     public/registrations#cancel
#     new_customer_registration GET    /customers/sign_up(.:format)                    public/registrations#new
#     edit_customer_registration GET    /customers/edit(.:format)                       public/registrations#edit
#         customer_registration PATCH  /customers(.:format)                            public/registrations#update
#                               PUT    /customers(.:format)                            public/registrations#update
#                               DELETE /customers(.:format)                            public/registrations#destroy
#                               POST   /customers(.:format)                            public/registrations#create
#               customers_mypage GET    /customers/mypage(.:format)                     public/customers#show
#     edit_mail_address_customer GET    /customers/:id/edit_mail_address(.:format)      public/customers#edit_mail_address
#         edit_password_customer GET    /customers/:id/edit_password(.:format)          public/customers#edit_password
#   edit_physical_info_customer GET    /customers/:id/edit_physical_info(.:format)     public/customers#edit_physical_info
#   update_mail_address_customer PATCH  /customers/:id/update_mail_address(.:format)    public/customers#update_mail_address
#       update_password_customer PATCH  /customers/:id/update_password(.:format)        public/customers#update_password
# update_physical_info_customer PATCH  /customers/:id/update_physical_info(.:format)   public/customers#update_physical_info
#           unsubscribe_customer GET    /customers/:id/unsubscribe(.:format)            public/customers#unsubscribe
#                               GET    /customers/:id/unsubscribe(.:format)            public/customers#unsubscribe
#             defection_customer PATCH  /customers/:id/defection(.:format)              public/customers#defection
#                 edit_customer GET    /customers/:id/edit(.:format)                   public/customers#edit
#                       customer PATCH  /customers/:id(.:format)                        public/customers#update
#                               PUT    /customers/:id(.:format)                        public/customers#updat


#<管理者(admin)>

#         new_admin_session GET    /admin/sign_in(.:format)                admin/sessions#new
#             admin_session POST   /admin/sign_in(.:format)                admin/sessions#create
#     destroy_admin_session DELETE /admin/sign_out(.:format)               admin/sessions#destroy
# cancel_admin_registration GET    /admin/cancel(.:format)                 admin/registrations#cancel
#   new_admin_registration GET    /admin/sign_up(.:format)                admin/registrations#new
#   edit_admin_registration GET    /admin/edit(.:format)                   admin/registrations#edit
#       admin_registration PATCH  /admin(.:format)                        admin/registrations#update
#                           PUT    /admin(.:format)                        admin/registrations#update
#                           DELETE /admin(.:format)                        admin/registrations#destroy
#                           POST   /admin(.:format)                        admin/registrations#create
#               admin_root GET    /admin(.:format)                        admin/homes#home
#   admin_customerss_index GET    /admin/customerss(.:format)             admin/customerss#index
#     edit_admin_customerss GET    /admin/customerss/:id/edit(.:format)    admin/customerss#edit
#         admin_customerss PATCH  /admin/customerss/:id(.:format)         admin/customerss#update
#                           PUT    /admin/customerss/:id(.:format)         admin/customerss#update
#             admin_columns GET    /admin/columns(.:format)                admin/columns#index
#         edit_admin_column GET    /admin/columns/:id/edit(.:format)       admin/columns#edit
#             admin_column PATCH  /admin/columns/:id(.:format)            admin/columns#update
#                           PUT    /admin/columns/:id(.:format)            admin/columns#update
#           admin_trainings GET    /admin/trainings(.:format)              admin/trainings#index
#                           POST   /admin/trainings(.:format)              admin/trainings#create
#       edit_admin_training GET    /admin/trainings/:id/edit(.:format)     admin/trainings#edit
#           admin_training PATCH  /admin/trainings/:id(.:format)          admin/trainings#update
#                           PUT    /admin/trainings/:id(.:format)          admin/trainings#update
#                           DELETE /admin/trainings/:id(.:format)          admin/trainings#destroy

