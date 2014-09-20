class SuperChallengesController < ApplicationController
  before_action :set_super_challenge, only: [:show, :edit, :update, :destroy]

  def index
    @super_challenges = SuperChallenge.all
  end

  def show
  end

  def new
    @id = params[:id]
    @super_challenge = SuperChallenge.new
  end

  def edit
  end

  def create
    @super_challenge = SuperChallenge.new(super_challenge_params)

    respond_to do |format|
      if @super_challenge.save
        format.html { redirect_to @super_challenge, notice: 'Super Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @super_challenge }
      else
        format.html { render :new }
        format.json { render json: @super_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @super_challenge.update(super_challenge_params)
        format.html { redirect_to @super_challenge, notice: 'Super Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @super_challenge }
      else
        format.html { render :edit }
        format.json { render json: @super_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @super_challenge.destroy
    respond_to do |format|
      format.html { redirect_to super_challenges_url, notice: 'Super Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_super_challenge
      @super_challenge = SuperChallenge.find(params[:id])
    end

    def super_challenge_params
      params.require(:super_challenge).permit(:day_id, :notes, :push_ups, :pull_ups, :duration, :distance, :times_walked)
    end
end
