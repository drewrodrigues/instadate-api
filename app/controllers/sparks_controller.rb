class SparksController < ApplicationController
  before_action :set_spark, only: :destroy

  # GET /sparks
  # GET /sparks.json
  def index
    @sparks = current_user.received_sparks
                          .includes(:user, user: :picture)
  end

  # POST /sparks
  # POST /sparks.json
  def create
    @spark = current_user.sent_sparks.build(spark_params)

    if @spark.save
      render @spark
    else
      render json: @spark.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /sparks/1
  # DELETE /sparks/1.json
  def destroy
    @spark.destroy
    render json: @spark
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_spark
    @spark = current_user.sparks.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spark_params
    params.require(:spark).permit(:instadate_id, :note)
  end
end
