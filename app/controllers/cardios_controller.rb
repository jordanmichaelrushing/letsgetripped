class CardiosController < ApplicationController
  before_action :set_cardio, only: [:show, :edit, :update, :destroy]

  # GET /cardios
  # GET /cardios.json
  def index
    @cardios = current_user.cardio.all
  end

  # GET /cardios/1
  # GET /cardios/1.json
  def show
  end

  # GET /cardios/new
  def new
    @day_id = params[:day]
    @id = params[:id]
    @cardio = current_user.cardios.new
  end

  # GET /cardios/1/edit
  def edit
    @day_id = params[:day]
  end

  # POST /cardios
  # POST /cardios.json
  def create
    @cardio = current_user.cardios.new(cardio_params)

    respond_to do |format|
      if @cardio.save
        format.html { redirect_to @cardio, notice: 'Cardio was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /cardios/1
  # PATCH/PUT /cardios/1.json
  def update
    respond_to do |format|
      if @cardio.update(cardio_params)
        format.html { redirect_to @cardio, notice: 'Cardio was successfully updated.' }
        format.json { render :show, status: :ok, location: @cardio }
      else
        format.html { render :edit }
        format.json { render json: @cardio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cardios/1
  # DELETE /cardios/1.json
  def destroy
    @cardio.destroy
    respond_to do |format|
      format.html { redirect_to cardios_url, notice: 'Cardio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cardio
      @cardio = current_user.cardios.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cardio_params
      params.require(:cardio).permit(:date, :day_id, :name, :notes, :duration, :distance, :sixty_percent_speed, :eighty_percent_speed, :ninety_percent_speed, :one_hundred_percent_speed, :times_walked, :user_id)
    end
end
