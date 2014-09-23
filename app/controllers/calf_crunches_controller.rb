class CalfCrunchesController < ApplicationController
  before_action :set_calf_crunch, only: [:show, :edit, :update, :destroy]

  def index
    @calf_crunches = current_user.calf_crunches.all
  end

  def show
  end

  def new
    @day_id = params[:day]
    @calf_crunch = current_user.calf_crunches.new
  end

  def edit
    @day_id = params[:day]
  end

  def create
    @calf_crunch = current_user.calf_crunches.new(calf_crunch_params)

    respond_to do |format|
      if @calf_crunch.save
        format.html { redirect_to @calf_crunch, notice: 'Calf crunch was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @calf_crunch.update(calf_crunch_params)
        format.html { redirect_to @calf_crunch, notice: 'Calf crunch was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @calf_crunch.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Calf crunch was successfully destroyed.' }
    end
  end

  private
    def set_calf_crunch
      @calf_crunch = CalfCrunch.find(params[:id])
    end

    def calf_crunch_params
      params.require(:calf_crunch).permit(:type, :set, :reps, :day_id, :set_type)
    end
end
