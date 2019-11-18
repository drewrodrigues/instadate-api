class InstadatesController < ApplicationController
  before_action :set_instadate, only: [:show, :edit, :update, :destroy]

  # GET /instadates
  # GET /instadates.json
  def index
    @instadates = Instadate.all
  end

  # GET /instadates/1
  # GET /instadates/1.json
  def show
  end

  # GET /instadates/new
  def new
    @instadate = Instadate.new
  end

  # GET /instadates/1/edit
  def edit
  end

  # POST /instadates
  # POST /instadates.json
  def create
    @instadate = Instadate.new(instadate_params)

    respond_to do |format|
      if @instadate.save
        format.html { redirect_to @instadate, notice: 'Instadate was successfully created.' }
        format.json { render :show, status: :created, location: @instadate }
      else
        format.html { render :new }
        format.json { render json: @instadate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instadates/1
  # PATCH/PUT /instadates/1.json
  def update
    respond_to do |format|
      if @instadate.update(instadate_params)
        format.html { redirect_to @instadate, notice: 'Instadate was successfully updated.' }
        format.json { render :show, status: :ok, location: @instadate }
      else
        format.html { render :edit }
        format.json { render json: @instadate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instadates/1
  # DELETE /instadates/1.json
  def destroy
    @instadate.destroy
    respond_to do |format|
      format.html { redirect_to instadates_url, notice: 'Instadate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instadate
      @instadate = Instadate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instadate_params
      params.require(:instadate).permit(:activity, :location, :time, :creator_id, :partner_id)
    end
end
