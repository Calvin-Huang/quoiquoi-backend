class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    # Default locale tw
    cookies[:locale] = params[:locale] || (cookies[:locale] || 'zh-TW')
    I18n.locale = cookies[:locale]
  end
end
