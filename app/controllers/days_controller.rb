class DaysController < ApplicationController
  before_action :set_day, only: [:edit, :update, :destroy]

  def index
    @days = current_user.days.all.order("date desc")
    @stats = Day.get_weekly_stats(current_user)
  end

  def show
    @day = Day.get_daily_stats(current_user,params[:id])
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
    unless (@day.video_url.nil?) || (@day.video_url.include? "http://")
      @day.video_url = "http://" + @day.video_url
    end

    respond_to do |format|
      if @day.save
        format.html { redirect_to @day, notice: 'Day was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @day.assign_attributes(day_params)
    unless (@day.video_url == "") || (@day.video_url.include? "http://")
      @day.video_url = "http://" + @day.video_url
    end
    respond_to do |format|
      if @day.save
        format.html { redirect_to @day, notice: 'Day was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @day.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Day was successfully destroyed.' }
    end
  end

  private
    def set_day
      @day = current_user.days.find(params[:id])
    end

    def day_params
      params.require(:day).permit(:date, :user_id, :video_url)
    end
end
