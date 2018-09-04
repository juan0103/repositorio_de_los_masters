class NovedadesController < ApplicationController
    def initialize            
    end
    def index
        render 'viewnovedades', layout: 'mailer'
    end
   def getnovedades
   end

    def createnovedad
  
        @numvisita=VisitaAuditor.maximum('id_visita').to_i
        @empresa=Empresa.all
        @Pai=Pai.all
        @Departamento=Departamento.all
        @Ciudad=Ciudad.all
        @BranchOffice= BranchOffice.all
        @Interesado= Interesado.all
        @TipoDeNovedad= TipoDeNovedad.all
        render 'createnovedades', layout: 'mailer'
    end

    def insertNovedad
    insertn=Novedad.new
    insertn.id_novedad = Novedad.maximum('id_novedad')+1
    insertn.detalle_novedad = params[:detallenovedad]
    insertn.id_interesado = params[:interesados]
    @hola = params[:interesados].to_s
    puts @hola
    insertn.id_visita = @numvisita
    puts "inserto numvisita"
    insertn.id_tipo_novedad = params[:selectTnovedad]
    puts "inserto tipo de novedad"
    insertn.save  
    puts "guardo"
        
    end
end
