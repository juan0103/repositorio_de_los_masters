class NovedadesController < ApplicationController
    def initialize     
        @visita=1       
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
        @TipoDeNovedad= TipoDeNovedade.all
        
        tipoVisita=VisitaAuditor.where(:id_visita => @visita)
        @tipovisita=tipoVisita[0].tipo_visita
        sucursal=BranchOffice.where(:id_sucursal => tipoVisita[0].id_sucursal)
        @sucursal=sucursal[0].desc_sucursal
        ciudad=Ciudad.where(:id_ciudad => sucursal[0].id_ciudad)
        @ciudad=ciudad[0].desc_ciudad
        departamento=Departamento.where(:id_departamento => ciudad[0].id_departamento)
        @departamento=departamento[0].desc_departamento

        pais=Pai.where(:id_pais => departamento[0].id_pais)
        @pais=pais[0].nombre_pais

        empresa=Empresa.where(:id_empresa => tipoVisita[0].id_empresa)
        @empresa=empresa[0].nombre_empresa







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
