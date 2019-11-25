class SexesController < ApplicationController
  before_action :set_sex, only: [:show, :update, :destroy]

  # GET /sexes
  def index
    @sexes = Sex.all

    render json: @sexes
  end

  # GET /sexes/1
  def show
    render json: @sex
  end

  # POST /sexes
  def create
    @sex = Sex.new(sex_params)

    if @sex.save
      render json: @sex, status: :created, location: @sex
    else
      render json: @sex.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sexes/1
  def update
    if @sex.update(sex_params)
      render json: @sex
    else
      render json: @sex.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sexes/1
  def destroy
    @sex.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sex
    @sex = Sex.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def sex_params
    params.require(:sex).permit(:name)
  end
end
