class DeparmentsController < ApplicationController
  before_action :set_deparment, only: [:show, :edit, :update, :destroy]

  # GET /deparments
  # GET /deparments.json
  def index
    @deparments = Deparment.all
  end

  # GET /deparments/1
  # GET /deparments/1.json
  def show
  end

  # GET /deparments/new
  def new
    @deparment = Deparment.new
  end

  # GET /deparments/1/edit
  def edit
  end

  # POST /deparments
  # POST /deparments.json
  def create
    @deparment = Deparment.new(deparment_params)

    respond_to do |format|
      if @deparment.save
        format.html { redirect_to @deparment, notice: 'Deparment was successfully created.' }
        format.json { render :show, status: :created, location: @deparment }
      else
        format.html { render :new }
        format.json { render json: @deparment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deparments/1
  # PATCH/PUT /deparments/1.json
  def update
    respond_to do |format|
      if @deparment.update(deparment_params)
        format.html { redirect_to @deparment, notice: 'Deparment was successfully updated.' }
        format.json { render :show, status: :ok, location: @deparment }
      else
        format.html { render :edit }
        format.json { render json: @deparment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deparments/1
  # DELETE /deparments/1.json
  def destroy
    @deparment.destroy
    respond_to do |format|
      format.html { redirect_to deparments_url, notice: 'Deparment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deparment
      @deparment = Deparment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deparment_params
      params.require(:deparment).permit(:id_departamento, :id_pais, :nombre_departamento)
    end
end
