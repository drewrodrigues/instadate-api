class SessionsController < ApplicationController
  # POST /sessions
  def create
    user = User.find_by(email: email)

    if user&.authenticate_password(password)
      session[:session_token] = user.session_token
      render json: user
      # render json: user.attributes.merge(picture: url_for(user.picture))
    else
      render json: ['Failed to authenticate'], status: :unprocessable_entity
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
