class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  helper_method :current_user
  before_action :set_locale
 
  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end
  
    I18n.locale = session[:locale] || I18n.default_locale
  end

  private
  def current_user
    User.find_by(email: session[:user_session])
  end

  def record_not_found
    render file: 'public/404.html', status: 404 , layout: false
  end
end
