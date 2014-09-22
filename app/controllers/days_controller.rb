class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :destroy]

  def index
    @days = current_user.days.all.order("date desc")
  end

  def show
  end

  def new
    @day_id = params[:day]
    @day = current_user.days.new
  end

  def edit
    @day_id = params[:day]
  end

  def create
    params[:date] = Date.parse(params[:day][:date])
    @day = current_user.days.new(day_params)

    respond_to do |format|
      if @day.save
        format.html { redirect_to @day, notice: 'Day was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @day.update(day_params)
        format.html { redirect_to @day, notice: 'Day was successfully updated.' }
        format.json { render :show, status: :ok, location: @day }
      else
        format.html { render :edit }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @day.destroy
    respond_to do |format|
      format.html { redirect_to days_url, notice: 'Day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_day
      @day = current_user.days.find(params[:id])
    end

    def day_params
      params.require(:day).permit(:date, :user_id)
    end
end
