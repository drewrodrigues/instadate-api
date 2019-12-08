class SparksController < ApplicationController
  # GET /sparks
  # GET /sparks.json
  def index
    @sparks = current_user.pending_sparks.includes(:user, user: :picture)
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
    @spark = current_user.received_sparks.find(params[:id])
    if @spark.update(denied: true)
      render json: @spark
    else
      render json: @spark.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def spark_params
    params.require(:spark).permit(:instadate_id, :note)
  end
end
