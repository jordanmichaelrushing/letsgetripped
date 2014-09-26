class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = current_user.exercises.all
  end

  def show
  end

  def new
    @day_id = params[:day]
    @exercise = current_user.exercises.new
  end

  def edit
    @day_id = params[:day]
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to @exercise, notice: 'Exercise was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Exercise was successfully destroyed.' }
    end
  end

  private
    def set_exercise
      @exercise = current_user.exercises.find(params[:id])
    end

    def exercise_params
      params.require(:exercise).permit(:name, :notes, :img_url, :set_one_weight, :set_two_weight, :set_three_weight, :set_four_weight, :amrap_quantity, :day_id, :user_id)
    end
end
