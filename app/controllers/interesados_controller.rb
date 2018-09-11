class InteresadosController < ApplicationController
  before_action :set_interesado, only: [:show, :edit, :update, :destroy]

  # GET /interesados
  # GET /interesados.json
  def index
    @interesados = Interesado.all
    render 'index', layout: 'mailer'
  end

  # GET /interesados/1
  # GET /interesados/1.json
  def show
    render 'show', layout: 'mailer'
  end

  # GET /interesados/new
  def new
    @interesado = Interesado.new
    render 'new', layout: 'mailer'
  end

  # GET /interesados/1/edit
  def edit
    render 'edit', layout: 'mailer'
  end

  # POST /interesados
  # POST /interesados.json
  def create
    @interesado = Interesado.new(interesado_params)

    respond_to do |format|
      if @interesado.save
        format.html { redirect_to @interesado, notice: 'Interesado was successfully created.' }
        format.json { render :show, status: :created, location: @interesado }
      else
        format.html { render :new }
        format.json { render json: @interesado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interesados/1
  # PATCH/PUT /interesados/1.json
  def update
    respond_to do |format|
      if @interesado.update(interesado_params)
        format.html { redirect_to @interesado, notice: 'Interesado was successfully updated.' }
        format.json { render :show, status: :ok, location: @interesado }
      else
        format.html { render :edit }
        format.json { render json: @interesado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interesados/1
  # DELETE /interesados/1.json
  def destroy
    @interesado.destroy
    respond_to do |format|
      format.html { redirect_to interesados_url, notice: 'Interesado was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interesado
      @interesado = Interesado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interesado_params
      params.require(:interesado).permit(:id_interesado, :desc_interesado)
    end
end
