class NovedadesController < ApplicationController
    def initialize            
    end
    def index
        render 'viewnovedades', layout: 'mailer'
    end
   def getnovedades
   end

    def createnovedad
        @empresa=Empresa.all
        @Pai=Pai.all
        @Departamento=Departamento.all
        @Ciudad=Ciudad.all
        @BranchOffice= BranchOffice.all
        @Interesado= Interesado.all
        @TipoDeNovedad= TipoDeNovedad.all
        render 'createnovedades', layout: 'mailer'
    end
end
