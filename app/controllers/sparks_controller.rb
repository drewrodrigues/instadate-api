class SparksController < ApplicationController
  before_action :set_spark, only: :destroy

  # GET /sparks
  # GET /sparks.json
  def index
    @sparks = Spark.all
  end

  # POST /sparks
  # POST /sparks.json
  def create
    @spark = Spark.new(spark_params)

    respond_to do |format|
      if @spark.save
        format.html { redirect_to @spark, notice: 'Spark was successfully created.' }
        format.json { render :show, status: :created, location: @spark }
      else
        format.html { render :new }
        format.json { render json: @spark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sparks/1
  # DELETE /sparks/1.json
  def destroy
    @spark.destroy
    respond_to do |format|
      format.html { redirect_to sparks_url, notice: 'Spark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_spark
    @spark = Spark.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spark_params
    params.require(:spark).permit(:instadate_id, :user_id, :note)
  end
end
