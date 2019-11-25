class InterestedInsController < ApplicationController
  before_action :set_interested_in, only: [:show, :update, :destroy]

  # GET /interested_ins
  def index
    @interested_ins = InterestedIn.all

    render json: @interested_ins
  end

  # GET /interested_ins/1
  def show
    render json: @interested_in
  end

  # POST /interested_ins
  def create
    @interested_in = InterestedIn.new(interested_in_params)

    if @interested_in.save
      render json: @interested_in, status: :created, location: @interested_in
    else
      render json: @interested_in.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interested_ins/1
  def update
    if @interested_in.update(interested_in_params)
      render json: @interested_in
    else
      render json: @interested_in.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interested_ins/1
  def destroy
    @interested_in.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_interested_in
    @interested_in = InterestedIn.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def interested_in_params
    params.require(:interested_in).permit(:user_id, :sex_id)
  end
end
