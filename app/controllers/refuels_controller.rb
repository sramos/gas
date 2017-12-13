class RefuelsController < ApplicationController
  before_action :set_refuel, only: [:show, :edit, :update, :destroy]

  # GET /refuels
  # GET /refuels.json
  def index
    @refuels = current_user.refuels.order("date desc")
  end

  # GET /refuels/1
  # GET /refuels/1.json
  def show
  end

  # GET /refuels/new
  def new
    @refuel = Refuel.new 
  end

  # GET /refuels/1/edit
  def edit
  end

  # POST /refuels
  # POST /refuels.json
  def create
    @refuel = Refuel.new(refuel_params)
    @refuel.user_id = current_user.id 
    if @refuel.save
      redirect_to refuels_path
    else
      render :new
    end
  end

  # PATCH/PUT /refuels/1
  # PATCH/PUT /refuels/1.json
  def update
  end

  # DELETE /refuels/1
  # DELETE /refuels/1.json
  def destroy
  end


 private

  # Use callbacks to share common setup or constraints between actions.
  def set_refuel
    @refuel = Refuel.find_by_id params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def refuel_params
    params.require(:refuel).permit(:date, :odometer, :volume, :cost, :price)
  end
end