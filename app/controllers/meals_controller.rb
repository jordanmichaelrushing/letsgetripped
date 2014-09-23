class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    @meals = current_user.meals.all
  end

  def show
  end

  def new
    @day_id = params[:day]
    @id = params[:id]
    @meal = current_user.meals.new
  end

  def edit
    @day_id = params[:day]
  end

  def create
    @meal = current_user.meals.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Meal was successfully destroyed.' }
    end
  end

  private
    def set_meal
      @meal = current_user.meals.find(params[:id])
    end

    def meal_params
      params.require(:meal).permit(:day_id, :name, :notes, :protein, :carbs, :fats, :sugar, :sodium, :saturated_fats, :cholesterol, :fiber, :meal_number, :user_id)
    end
end
