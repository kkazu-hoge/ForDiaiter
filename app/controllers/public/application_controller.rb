class Public::ApplicationController < ActionController::Base

  layout 'public/application'
  before_action :authenticate_customer!, except: [:top, :about, :term_of_service, :privacy_policie]

  # include ErrorHandlers


end
