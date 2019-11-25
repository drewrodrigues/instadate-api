class LookingForsController < ApplicationController
  before_action :set_looking_for, only: [:show, :update, :destroy]

  # GET /looking_fors
  def index
    @looking_fors = LookingFor.all

    render json: @looking_fors
  end

  # GET /looking_fors/1
  def show
    render json: @looking_for
  end

  # POST /looking_fors
  def create
    @looking_for = LookingFor.new(looking_for_params)

    if @looking_for.save
      render json: @looking_for, status: :created, location: @looking_for
    else
      render json: @looking_for.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /looking_fors/1
  def update
    if @looking_for.update(looking_for_params)
      render json: @looking_for
    else
      render json: @looking_for.errors, status: :unprocessable_entity
    end
  end

  # DELETE /looking_fors/1
  def destroy
    @looking_for.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_looking_for
    @looking_for = LookingFor.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def looking_for_params
    params.require(:looking_for).permit(:user_id, :outcome_id)
  end
end
