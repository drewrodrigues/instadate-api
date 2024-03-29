class InstadatesController < ApplicationController
  before_action :set_instadate, only: [:show, :destroy]

  # GET /instadates
  # GET /instadates.json
  def index
    @instadates = [current_user.created_instadate].compact
  end

  # GET /instadates/1
  # GET /instadates/1.json
  def show; end

  # POST /instadates
  # POST /instadates.json
  def create
    @instadate = current_user.build_created_instadate(instadate_params)

    if @instadate.save
      render @instadate
    else
      render json: @instadate.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /instadates
  # PATCH/PUT /instadates
  def update
    @instadate = current_user.created_instadate
    if @instadate.update(instadate_params)
      render :show, status: :ok, location: @instadate
    else
      render json: @instadate.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /instadates/1
  # DELETE /instadates/1.json
  def destroy
    @instadate.destroy
    render json: @instadate
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_instadate
    @instadate = Instadate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def instadate_params
    params.require(:instadate).permit(
      :activity,
      :time,
      :latitude,
      :longitude
    )
  end
end
