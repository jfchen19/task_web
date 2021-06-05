class ApplicationController < ActionController::Base
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
end
