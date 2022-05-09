Rails.application.routes.draw do

  namespace :public do
    get 'trainings/index'
    get 'trainings/show'
  end
  namespace :public do
    get 'search_gyms/index'
    get 'search_gyms/search'
  end
  namespace :public do
    get 'records/index'
    get 'records/show'
  end
  namespace :public do
    get 'projects/index'
    get 'projects/show'
    get 'projects/new'
    get 'projects/edit'
    get 'projects/cretae'
    get 'projects/update'
  end
  namespace :public do
    get 'pj_template_events/new'
    get 'pj_template_events/create'
    get 'pj_template_events/destroy'
    get 'pj_template_events/pj_event_add_training'
    get 'pj_template_events/show_event'
  end
  namespace :public do
    get 'pj_events/show'
    get 'pj_events/new'
    get 'pj_events/edit'
    get 'pj_events/update'
    get 'pj_events/destroy'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/home'
    get 'homes/pj_alter'
  end
  namespace :public do
    get 'columns/index'
    get 'columns/show'
  end
  namespace :public do
    get 'callenders/edit'
    get 'callenders/new'
    get 'callenders/show'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/edit_mail_address'
    get 'customers/edit_password'
    get 'customers/edit_physical_info'
    get 'customers/update'
    get 'customers/update_mail_address'
    get 'customers/update_password'
    get 'customers/update_physical_info'
    get 'customers/unsubscribe'
    get 'customers/defection'
  end
  namespace :admin do
    get 'columns/index'
    get 'columns/edit'
    get 'columns/create'
    get 'columns/update'
    get 'columns/destroy'
  end
  namespace :admin do
    get 'trainings/index'
    get 'trainings/edit'
    get 'trainings/update'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/edit'
    get 'customers/update'
  end
  namespace :admin do
    get 'homes/home'
  end
  # 会員
  # URLに"public"を含ませたくないためURLとファイル構成(public配下)が異なるscope moduleでルーティング定義
  scope module: 'public' do
    # root :to =>'registrations#new'
    # root :to =>'homes#top'
    # get "/about"=>'homes#about'
    devise_for :customers,skip: [:passwords], controllers: { registrations: 'public/registrations'}
  end

  #管理者
  # URLに"admin"にが含まれて問題ないためnamespaceでURLとファイル構成を同じように定義
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    # root :to =>'homes#top'
    # get "/about"=>'homes#about'

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
