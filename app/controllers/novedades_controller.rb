class NovedadesController < ApplicationController
    skip_before_action :verify_authenticity_token
    @cover 
    def initialize     
        puts "iniciando"        
        @visita=1 
        @listProcesos=nil      
    end
    def index
      
    @novxarea=Novedad.where(:id_interesado => idnov )  
        render 'viewnovedades', layout: 'mailer'
    end
   def getnovedades
    idnov= session[:id_area]
    puts "hola mundo"
    puts idnov
    @novxarea=Novedad.where(:id_interesado => idnov )  


    # getnv=Novedad.where("login=:nombre and password=:pass ",{nombre:params[:txtuser],pass:params[:txtpassword]}).first

   end

    def createnovedad
        ##puts "numero visita:"
        ##puts params[:numVisita]
        @numvisita=params[:numVisita]          
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
        if(params[:id_novedad]!=nil and  !params[:id_novedad].eql?(""))
            insertn=Novedad.find(params[:id_novedad])
        else
            idNovedad=idNovedad+1
        end

        insertn.id_novedad = idNovedad
    end 
    @numvisita=params[:numVisita] 
    insertn.detalle_novedad = params[:detallenovedad]
    insertn.id_interesado = params[:interesado]    
    insertn.id_visita = @numvisita
    insertn.id_tipo_novedad = params[:selectTnovedad]
    insertn.id_proceso_auditoria = params[:proceso]    
    insertn.titulo = params[:titulo]    
    insertn.estado_novedad="Abierto"
    if (insertn.save==true)               
        respond_to do |format|           
           format.html 
           format.json do
            getProceso insertn.id_proceso_auditoria
            render json:{title: "Registro", mensaje:"Se guardo correctamente",tipo:"success", list:@listProcesos}.to_json
            end
        
            insertn.id_novedad = idNovedad
        end 
        @numvisita=1  
        insertn.detalle_novedad = params[:detallenovedad]
        insertn.id_interesado = params[:interesado]    
        insertn.id_visita = @numvisita
        insertn.id_tipo_novedad = params[:selectTnovedad]
        insertn.id_proceso_auditoria = params[:proceso]    
        insertn.titulo = params[:titulo]    
        if (insertn.save==true)               
            respond_to do |format|           
               format.html 
               format.json do
                getProceso insertn.id_proceso_auditoria
                render json:{title: "Registro", mensaje:"Se guardo correctamente",tipo:"success", list:@listProcesos}.to_json
                end
            end
        else
            respond_to do |format|           
                format.html 
                format.json do
                    render json:{title: "Error", mensaje:"Sucedio un Problema Procesando su solictud por favor intentelo de nuevo",tipo:"error"}.to_json
                 end
             end
        end
        
    end


    def delete_novedad
        @numvisita=params[:numVisita]
        novedad=Novedad.find(params[:id_novedad])
        getProceso novedad.id_proceso_auditoria            
        novedad.destroy()                
        respond_to do |format|           
           format.html 
           format.json do
               render json:{title: "Elimino", mensaje:"Se elimino correctamente el registro",tipo:"success",list:@listProcesos}.to_json
              end
           end
       end
    

   def loadInformacion
        @numvisita=params[:numVisita]

        getProceso 1   
        listFacturas=@listProcesos

        getProceso 2   
        listImpuestos=@listProcesos

        getProceso 3   
        listSanidad=@listProcesos

        getProceso 4   
        listDian=@listProcesos

        getProceso 5   
        listFisicoTerreno=@listProcesos

        getProceso 6    
        listFisicoActivo=@listProcesos
        
        getProceso 7   
        listProductos=@listProcesos

        getProceso 8   
        listaReporteHoras=@listProcesos
        
        getProceso 9   
        listCargoEmp=@listProcesos
        
        getProceso 10   
        listConformidadEmpleado=@listProcesos
        
        getProceso 11   
        listSalidasEmergencia=@listProcesos
        
        getProceso 12   
        listFuegoEstab=@listProcesos
        
        getProceso 13   
        listIncendios=@listProcesos
        
        getProceso 14   
        listPersonalCapacitado=@listProcesos
        
        respond_to do |format|           
            format.html 
            format.json do
                render json:{listFacturas:listFacturas,listImpuestos:listImpuestos,listSanidad:listSanidad,listDian:listDian,listFisicoTerreno:listFisicoTerreno,listFisicoActivo:listFisicoActivo,listProductos:listProductos,listaReporteHoras:listaReporteHoras,listCargoEmp:listCargoEmp,listConformidadEmpleado:listConformidadEmpleado,listSalidasEmergencia:listSalidasEmergencia,listFuegoEstab:listFuegoEstab,listIncendios:listIncendios,listPersonalCapacitado:listPersonalCapacitado}.to_json
            end
        end
   end
   
   
   attr_accessor :cover 
   

   def save_image 
    puts "Inicio" 
    @id=18
    puts "Inicio"
    puts params[:bytes]
    insertn=Novedad.find(params[:id_novedad])
    puts "consulta"
   
    insertn.bytesImages=params[:bytes]    
    insertn.save

end

private
    def getProceso idProceso 
        @listProcesos=Novedad.select('nv.*,inte.desc_interesado,tp.desc_tnovedad').joins('nv  JOIN "seguridad"."INTERESADO" inte on inte.id_interesado=nv.id_interesado JOIN "seguridad"."TIPO_DE_NOVEDAD" tp on tp.id_tnovedad=nv.id_tipo_novedad').where(" nv.id_visita=#{@numvisita} and nv.id_proceso_auditoria=#{idProceso}").order("id_novedad ASC")
    end

end
