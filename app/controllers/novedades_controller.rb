class NovedadesController < ApplicationController
    skip_before_action :verify_authenticity_token
    @cover 
    def initialize     
        puts "iniciando"        
        @listProcesos=nil      
        @visita=1 
        @listProcesos=nil 
        @selectarea=Interesado.all 
    end
    def index
        @id_area=session[:id_area]
        session[:listnovedades]=Novedad.select('nv.id_novedad,us.nombre, nv.titulo, tp.desc_tnovedad, nv.estado_novedad, e.nombre_empresa, s.desc_sucursal, va.fecha_visita, nv.detalle_novedad').joins('nv JOIN "seguridad"."VISITA_AUDITOR" va on va.id_visita=nv.id_visita JOIN "seguridad"."tbusuario" us on us.id=va.id_usuario JOIN "seguridad"."TIPO_DE_NOVEDAD" tp on tp.id_tnovedad=nv.id_tipo_novedad  JOIN "seguridad"."SUCURSAL" s on s.id_sucursal=va.id_sucursal JOIN "seguridad"."EMPRESA" e on e.id_empresa=s.id_empresa' ).where("nv.id_interesado=#{@id_area}")
        render 'viewnovedades', layout: 'mailer'
    end
   

    def createnovedad
        ##puts "numero visita:"
        ##puts params[:numVisita]
        @numvisita=params[:numVisita]          
        @empresa=Empresa.all
        @Pai=Pai.all
        @Departamento=Departamento.all
        @Ciudad=Ciudade.all
        @BranchOffice= BranchOffice.all
        @Interesado= Interesado.all
        @TipoDeNovedad= TipoDeNovedade.all
        
        tipoVisita=VisitaAuditor.where(:id_visita => @numvisita)
        @tipovisita=tipoVisita[0].tipo_visita        
        @estadoVisita=tipoVisita[0].estado
        puts "Estado visita:"
        puts @estadoVisita
        if(@estadoVisita=='Iniciada')
            @class='success'
        else
            @class='danger'
        end
        sucursal=BranchOffice.where(:id_sucursal => tipoVisita[0].id_sucursal)
        @sucursal=sucursal[0].desc_sucursal
        ciudad=Ciudade.where(:id_ciudad => sucursal[0].id_ciudad)
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
        insertn=Novedad.new
        idNovedad= Novedad.maximum('id_novedad');
        if(idNovedad==nil)
           idNovedad=1;
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
    
       def finalizarVisita
        @numvisita=params[:numVisita]
        visita=VisitaAuditor.find(params[:numVisita])                
        visita.estado='Finalizada'                
        if (visita.save==true)               
            respond_to do |format|           
               format.html 
               format.json do
                render json:{title: "Registro", mensaje:"Se actualizo correctamente",tipo:"success"}.to_json
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

def verhoy
    @id_area=session[:id_area]
    session[:fecha]=Time.now
    session[:listnovedades]=Novedad.select('nv.id_novedad, us.nombre, nv.titulo, tp.desc_tnovedad, nv.estado_novedad, e.nombre_empresa, s.desc_sucursal, va.fecha_visita, nv.detalle_novedad').joins('nv JOIN "seguridad"."VISITA_AUDITOR" va on va.id_visita=nv.id_visita JOIN "seguridad"."tbusuario" us on us.id=va.id_usuario JOIN "seguridad"."TIPO_DE_NOVEDAD" tp on tp.id_tnovedad=nv.id_tipo_novedad  JOIN "seguridad"."SUCURSAL" s on s.id_sucursal=va.id_sucursal JOIN "seguridad"."EMPRESA" e on e.id_empresa=s.id_empresa' ).where("nv.id_interesado=#{@id_area} and va.fecha_visita ='#{session[:fecha].year}-#{session[:fecha].month}-#{session[:fecha].day}'")
    render 'viewnovedades', layout: 'mailer'
end
def entre
    @id_area=session[:id_area]
    @fecha1=params[:datetimepickerfecha1].to_s
    @fecha2=params[:datetimepickerfecha2].to_s
    if (params[:estadolist].to_s == "Todas")
            @estadolist="1"
    end
    if (params[:estadolist].to_s == "Abiertas")
        @estadolist="Cerrada"
    end
    if (params[:estadolist].to_s == "Cerradas")
        @estadolist="Abierto"
    end
    session[:listnovedades]=Novedad.select('nv.id_novedad, us.nombre, nv.titulo, tp.desc_tnovedad, nv.estado_novedad, e.nombre_empresa, s.desc_sucursal, va.fecha_visita, nv.detalle_novedad').joins('nv JOIN "seguridad"."VISITA_AUDITOR" va on va.id_visita=nv.id_visita JOIN "seguridad"."tbusuario" us on us.id=va.id_usuario JOIN "seguridad"."TIPO_DE_NOVEDAD" tp on tp.id_tnovedad=nv.id_tipo_novedad  JOIN "seguridad"."SUCURSAL" s on s.id_sucursal=va.id_sucursal JOIN "seguridad"."EMPRESA" e on e.id_empresa=s.id_empresa' ).where("nv.id_interesado=#{@id_area} and va.fecha_visita between '#{@fecha1}' and '#{@fecha2}' and nv.estado_novedad !='#{@estadolist}'")
    render 'viewnovedades', layout: 'mailer'
end

def getnovedades
    @id_area=session[:id_area]
    respond_to do |format|           
        format.html 
        format.json do
            render json:{listnovedades:session[:listnovedades]}.to_json
        end
    end

end


def escalar
    begin
        idnovedad=params[:txtidescalarnovedad]
        nameinteresado=params[:selectInteresado]
        idinteresadoescalar=Interesado.where(:desc_interesado => nameinteresado)
        @idinteresadoescalar=idinteresadoescalar[0].id_interesado
        Novedad.update(idnovedad, :id_interesado => @idinteresadoescalar )
        @message = "se ha Escalado correctamente la novedad"
        @tipo="success"
        render 'viewnovedades', layout: 'mailer'
    rescue => exception
        @message = "Ha fallado el proceso por favor inetente nuevamente "
        @tipo="error"
        render 'viewnovedades', layout: 'mailer'
    end
     
    #  Novedad.update(idnovedad, :)
end
def cerrarnovedad
    begin
        idnovedad=params[:closenov]
        solucionNovedad=params[:solucionnovedad]
        Novedad.update(idnovedad, :solucion_novedad => params[:solucionnovedad], :estado_novedad => 'Cerrado')
        @message = "se ha Cerrado la novedad Correctamente"
        @tipo="success"
        render 'viewnovedades', layout: 'mailer'
    rescue => exception
        @message = "Ha fallado el proceso por favor inetente nuevamente "
        @tipo="error"
        render 'viewnovedades', layout: 'mailer'
    end
    
end


def viewUploadImage    
    render 'viewnovedades', layout: 'mailer'
end

attr_accessor :upload 
   def uploadImage
    ImageNovedadesUploader.uploadImageLogic(params[:upload]) 
    render 'uploadImage', layout: 'mailer' 
end


private
    def getProceso idProceso 
        @listProcesos=Novedad.select('nv.*,inte.desc_interesado,tp.desc_tnovedad').joins('nv  JOIN "seguridad"."INTERESADO" inte on inte.id_interesado=nv.id_interesado JOIN "seguridad"."TIPO_DE_NOVEDAD" tp on tp.id_tnovedad=nv.id_tipo_novedad').where(" nv.id_visita=#{@numvisita} and nv.id_proceso_auditoria=#{idProceso}").order("id_novedad ASC")
    end

end

