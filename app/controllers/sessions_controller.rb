class SessionsController < ApplicationController
  def create
    user = User.find_by(email: email)

    if user.authenticate_password(password)
      render json: user
    else
      render json: {
        errors: ['Failed to authenticate']
      }, status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def email
    session_params[:email]
  end

  def password
    session_params[:password]
  end
end
