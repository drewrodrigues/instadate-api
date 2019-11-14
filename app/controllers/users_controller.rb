class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    binding.pry
    @user = User.new(user_params)
    @user.picture = Picture.find(picture_id) if picture_id

    if @user.save
      session[:session_token] = @user.session_token
      render @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :age,
      :location,
      :sex,
      :bio,
      :name,
      :outcomes => [],
      :interested_in => []
    )
  end

  def picture_id
    params[:user][:picture_id]
  end
end
