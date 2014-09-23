class PushupsController < ApplicationController
  before_action :set_pushup, only: [:show, :edit, :update, :destroy]

  def index
    @pushups = current_user.pushups.all
  end

  def show
  end

  def new
    @day_id = params[:day]
    @pushup = current_user.pushups.new
  end

  def edit
    @day_id = params[:day]
  end

  def create
    @pushup = current_user.pushups.new(pushup_params)

    respond_to do |format|
      if @pushup.save
        format.html { redirect_to @pushup, notice: 'Pushup was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @pushup.update(pushup_params)
        format.html { redirect_to @pushup, notice: 'Pushup was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pushup.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Pushup was successfully destroyed.' }
    end
  end

  private
    def set_pushup
      @pushup = Pushup.find(params[:id])
    end

    def pushup_params
      params.require(:pushup).permit(:set_one_reps, :set_two_reps, :set_three_reps, :day_id, :user_id)
    end
end
