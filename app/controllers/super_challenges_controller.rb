class SuperChallengesController < ApplicationController
  before_action :set_super_challenge, only: [:show, :edit, :update, :destroy]

  def index
    @super_challenges = SuperChallenge.all
  end

  def show
    @day_id = params[:day]
    if @super_challenge.duration
      if @super_challenge.duration > 18
        time = 100 - ((@super_challenge.duration * 60 - 1080) / 10).to_i
        time = 0 if time < 0
      else
        time = 100
      end
    else
      time = 0
    end
    if @super_challenge.push_ups >= 50
      push_ups = 100
    else
      push_ups = @super_challenge.push_ups * 2 || 0
    end
    if @super_challenge.pull_ups >= 20
      pull_ups = 100
    else
      pull_ups = @super_challenge.pull_ups * 5 || 0
    end
    @score = pull_ups + push_ups + time
  end

  def new
    @day_id = params[:day]
    @id = params[:id]
    @super_challenge = SuperChallenge.new
  end

  def edit
    @day_id = params[:day]
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
