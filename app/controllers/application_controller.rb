# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  include Pagy::Backend

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  private

  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '')&.scan(/[a-z]{2}/)&.first
  end
end
