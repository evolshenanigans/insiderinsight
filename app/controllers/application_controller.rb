class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Ensure that your application forms and redirects will carry the current locale
  def default_url_options
    { locale: I18n.locale }
  end
end
