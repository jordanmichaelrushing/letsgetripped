class CardiosController < ApplicationController
  before_action :set_cardio, only: [:show, :edit, :update, :destroy]

  def index
    @cardios = current_user.cardio.all
  end

  def show
  end

  def new
    @day_id = params[:day]
    @id = params[:id]
    @cardio = current_user.cardios.new
  end

  def edit
    @day_id = params[:day]
  end

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

  def update
    respond_to do |format|
      if @cardio.update(cardio_params)
        format.html { redirect_to @cardio, notice: 'Cardio was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @cardio.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Cardio was successfully destroyed.' }
    end
  end

  private
    def set_cardio
      @cardio = current_user.cardios.find(params[:id])
    end

    def cardio_params
      params.require(:cardio).permit(:date, :day_id, :name, :notes, :duration, :distance, :sixty_percent_speed, :eighty_percent_speed, :ninety_percent_speed, :one_hundred_percent_speed, :times_walked, :user_id)
    end
end
