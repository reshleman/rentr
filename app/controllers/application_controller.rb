class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  before_action :require_login

  protect_from_forgery with: :exception

  def current_user
    super || GuestUser.new
  end
end
