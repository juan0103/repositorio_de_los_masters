class TipoDeNovedadesController < ApplicationController
  before_action :set_tipo_de_novedade, only: [:show, :edit, :update, :destroy]

  # GET /tipo_de_novedades
  # GET /tipo_de_novedades.json
  def index
    @tipo_de_novedades = TipoDeNovedade.all
    render 'index', layout: 'mailer'
  end

  # GET /tipo_de_novedades/1
  # GET /tipo_de_novedades/1.json
  def show
    render 'show', layout: 'mailer'
  end

  # GET /tipo_de_novedades/new
  def new
    @tipo_de_novedade = TipoDeNovedade.new
    render 'new', layout: 'mailer'
  end

  # GET /tipo_de_novedades/1/edit
  def edit
    render 'edit', layout: 'mailer'
  end

  # POST /tipo_de_novedades
  # POST /tipo_de_novedades.json
  def create
    @tipo_de_novedade = TipoDeNovedade.new(tipo_de_novedade_params)

    respond_to do |format|
      if @tipo_de_novedade.save
        format.html { redirect_to @tipo_de_novedade, notice: 'Tipo de novedade was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_de_novedade }
      else
        format.html { render :new }
        format.json { render json: @tipo_de_novedade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_de_novedades/1
  # PATCH/PUT /tipo_de_novedades/1.json
  def update
    respond_to do |format|
      if @tipo_de_novedade.update(tipo_de_novedade_params)
        format.html { redirect_to @tipo_de_novedade, notice: 'Tipo de novedade was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_de_novedade }
      else
        format.html { render :edit }
        format.json { render json: @tipo_de_novedade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_de_novedades/1
  # DELETE /tipo_de_novedades/1.json
  def destroy
    @tipo_de_novedade.destroy
    respond_to do |format|
      format.html { redirect_to tipo_de_novedades_url, notice: 'Tipo de novedade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_de_novedade
      @tipo_de_novedade = TipoDeNovedade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_de_novedade_params
      params.require(:tipo_de_novedade).permit(:id_tnovedad, :desc_tnovedad)
    end
end
