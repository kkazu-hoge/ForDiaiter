Rails.application.routes.draw do

  # 会員
  # URLに"public"を含ませたくないためURLとファイル構成(public配下)が異なるscope moduleでルーティング定義
  scope module: 'public' do
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
