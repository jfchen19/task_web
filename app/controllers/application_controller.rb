class ApplicationController < ActionController::Base
  before_action :set_locale
  # before_action :switch_locale
 
  def set_locale
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end
  
    I18n.locale = session[:locale] || I18n.default_locale
  end

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  # def switch_locale(&action)
  #   locale = params[:locale] || I18n.default_locale
  #   I18n.with_locale(locale, &action)
  # end

  # def default_url_options(options = {})
  #   { :locale => I18n.locale }.merge options
  # end

  # def extract_locale_from_tld
  #   parsed_locale = request.subdomains.first
  #   I18n.available_locales.map(&:to_s).include?(parsed_locale) ?      
  #   parsed_locale : nil
  # end
end
