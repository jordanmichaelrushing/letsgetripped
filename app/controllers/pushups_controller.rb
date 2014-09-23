class PushupsController < ApplicationController
  before_action :set_pushup, only: [:show, :edit, :update, :destroy]

  # GET /pushups
  # GET /pushups.json
  def index
    @pushups = current_user.pushups.all
  end

  # GET /pushups/1
  # GET /pushups/1.json
  def show
  end

  # GET /pushups/new
  def new
    @day_id = params[:day]
    @pushup = current_user.pushups.new
  end

  # GET /pushups/1/edit
  def edit
    @day_id = params[:day]
  end

  # POST /pushups
  # POST /pushups.json
  def create
    @pushup = current_user.pushups.new(pushup_params)

    respond_to do |format|
      if @pushup.save
        format.html { redirect_to @pushup, notice: 'Pushup was successfully created.' }
        format.json { render :show, status: :created, location: @pushup }
      else
        format.html { render :new }
        format.json { render json: @pushup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pushups/1
  # PATCH/PUT /pushups/1.json
  def update
    respond_to do |format|
      if @pushup.update(pushup_params)
        format.html { redirect_to @pushup, notice: 'Pushup was successfully updated.' }
        format.json { render :show, status: :ok, location: @pushup }
      else
        format.html { render :edit }
        format.json { render json: @pushup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pushups/1
  # DELETE /pushups/1.json
  def destroy
    @pushup.destroy
    respond_to do |format|
      format.html { redirect_to pushups_url, notice: 'Pushup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pushup
      @pushup = Pushup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pushup_params
      params.require(:pushup).permit(:set_one_reps, :set_two_reps, :set_three_reps, :day_id, :user_id)
    end
end
