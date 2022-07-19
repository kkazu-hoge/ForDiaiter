Rails.application.routes.draw do

  # 会員
  # URLに"public"を含ませたくないためURLとファイル構成(public配下)が異なるscope moduleでルーティング定義

  #ローカルでメール送信をチェック
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  scope module: 'public' do
    root :to          =>'homes#top'
    get   "/home"     =>'homes#home'
    get  "/pj_alter" =>'homes#pj_alter'

    devise_for :customers,skip: [:passwords], controllers: {
      registrations: 'public/registrations'
    }

    #deviseのルーティングと被るためeditとupdateは独自で定義
    get "customers/mypage_edit"=>"customers#edit"
    patch "customers/mypage_update"=>"customers#update"
    resource :customers, only: [:show] do
      get   :edit_mail_address
      get   :term_of_service
      get   :privacy_policie
      patch :update_mail_address
      get   :unsubscribe
      patch :defection
    end

    resources :projects,  only: [:index, :show, :new, :edit, :create, :update] do
      get :new_wizard2, on: :collection
      get :new_wizard3, on: :collection
      get :complete, on: :collection
    end
    resources :pj_events, only: [:new, :create, :update, :destroy] do
      get :new_training, on: :collection
      get :pj_event_add_training_new,    on: :collection
      get :pj_event_delete_training_new, on: :collection
    end

    resources :pj_template_events, only: [:new] do
      get :pj_event_add_training,    on: :collection
      get :pj_event_delete_training, on: :collection
    end

    resources :callenders,  only: [:show, :edit, :update]
    resources :records,     only: [:index, :show]
    resources :trainings,   only: [:index, :show]

    resources :search_gyms, only: [:index] do
      get :search, on: :collection
    end

    resources :columns, only: [:index]

    resources :contacts, only: [:new, :create]

  end
  #ゲストログイン用のルーティング
  devise_scope :customer do
    post '/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end



  #管理者
  # URLに"admin"にが含まれて問題ないためnamespaceでURLとファイル構成を同じように定義
  devise_for :admin, skip: [:passwords], controllers: {
    sessions: "admin/sessions",
    registrations: "admin/registrations"
  }

  namespace :admin do

    root :to =>'homes#home'
    resources :customers,  only: [:index, :edit, :update]
    resources :columns,     only: [:index, :edit, :update]
    resources :trainings,   only: [:index, :edit, :create, :update, :destroy]

  end

  #ルーティングに該当しないURLに対して例外処理
  match "*path" => "application#rescue404", via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
