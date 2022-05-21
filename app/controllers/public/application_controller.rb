class Public::ApplicationController < ActionController::Base

  layout 'public/application'
  # before_action :authenticate_customer!, except: [:top, :about]

  # デプロイ時にコメントアウト解放
  # include ErrorHandlers


end
