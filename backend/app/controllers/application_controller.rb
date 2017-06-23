class ApplicationController < ActionController::API
  include Knock::Authenticable
  include CanCan::ControllerAdditions
  check_authorization

  before_action :set_paper_trail_whodunnit
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || request.headers['locale'] || I18n.default_locale
  end

  rescue_from CanCan::AccessDenied do |_exception|
    head :forbidden
  end
end
