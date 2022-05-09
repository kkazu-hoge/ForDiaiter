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
