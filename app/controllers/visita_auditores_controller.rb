class VisitaAuditoresController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @Empresas= Empresa.all
        render 'index', layout: 'mailer'
    end


    def createVisita
        insertVisita=VisitaAuditor.new
        idVisita=VisitaAuditor.maximum('id_visita');
        if(idVisita==nil)
            idVisita=1;
        else
            idVisita=idVisita+1
        end

        insertVisita.id_visita= idVisita
        insertVisita.tipo_visita= 'Programada'
        insertVisita.id_usuario= session[:usuario]
        insertVisita.id_sucursal= params[:id_sucursal]
        insertVisita.id_empresa= params[:id_empresa]
        insertVisita.fecha_visita= params[:fecha_visita]
        listVisitas=VisitaAuditor.select('VA.*,EMP.NOMBRE_EMPRESA,SUC.DESC_SUCURSAL,to_char(VA.FECHA_VISITA, \'DD/MM/YYYY\') FECHA_STR,to_char(VA.FECHA_VISITA,\'DD\') DIA').joins('VA  JOIN "seguridad"."EMPRESA" EMP ON EMP.ID_EMPRESA=VA.ID_EMPRESA  JOIN "seguridad"."SUCURSAL" SUC ON SUC.ID_SUCURSAL=VA.ID_SUCURSAL').where(" to_char(VA.FECHA_VISITA,'YYYY')='#{params[:year]}'  AND to_char(VA.FECHA_VISITA,'MM')='#{params[:mes]}' ")
        if (insertVisita.save==true)               
            respond_to do |format|           
               format.html 
               format.json do
                getProceso insertn.id_proceso_auditoria
                render json:{title: "Registro", mensaje:"Se guardo correctamente",tipo:"success", visitas:@listVisitas}.to_json
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

    def getInfo
        listVisitas=VisitaAuditor.select('VA.*,EMP.NOMBRE_EMPRESA,SUC.DESC_SUCURSAL,to_char(VA.FECHA_VISITA, \'DD/MM/YYYY\') FECHA_STR,to_char(VA.FECHA_VISITA,\'DD\') DIA').joins('VA  JOIN "seguridad"."EMPRESA" EMP ON EMP.ID_EMPRESA=VA.ID_EMPRESA  JOIN "seguridad"."SUCURSAL" SUC ON SUC.ID_SUCURSAL=VA.ID_SUCURSAL').where(" to_char(VA.FECHA_VISITA,'YYYY')='#{params[:year]}'  AND to_char(VA.FECHA_VISITA,'MM')='#{params[:mes]}' ")
        respond_to do |format|           
            format.html 
            format.json do
                render json:{visitas:listVisitas}.to_json
             end
         end
    end


    def getSucursales
        listSucursales=Sucursal.where(:id_empresa => params[:idEmpresa])
        respond_to do |format|           
            format.html 
            format.json do
                render json:{sucursales:listSucursales}.to_json
             end
         end
    end
end
