# frozen_string_literal: true

class ApplicationController < ActionController::API
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session_token)
  end

  private

  def session_token
    request.authorization
  end
end
