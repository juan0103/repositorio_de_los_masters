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
        insertVisita.id_usuario= session[:usuario_id]
        insertVisita.id_sucursal= params[:id_sucursal]
        insertVisita.id_empresa= params[:id_empresa]
        insertVisita.fecha_visita= params[:fecha_visita]
        insertVisita.estado= 'Iniciada'
        puts  "fecha "
        puts  params[:fecha_visita]
        listVisitas=VisitaAuditor.select('VA.*,EMP.NOMBRE_EMPRESA,SUC.DESC_SUCURSAL,to_char(VA.FECHA_VISITA, \'DD/MM/YYYY\') FECHA_STR,to_char(VA.FECHA_VISITA,\'DD\') DIA').joins('VA  JOIN "seguridad"."EMPRESA" EMP ON EMP.ID_EMPRESA=VA.ID_EMPRESA  JOIN "seguridad"."SUCURSAL" SUC ON SUC.ID_SUCURSAL=VA.ID_SUCURSAL').where(" to_char(VA.FECHA_VISITA,'YYYY')='#{params[:year]}'  AND to_char(VA.FECHA_VISITA,'MM')='#{params[:mes]}' AND VA.id_usuario='#{session[:usuario_id]}' ")
        if (insertVisita.save==true)               
            respond_to do |format|           
               format.html 
               format.json do                
                render json:{title: "Registro", mensaje:"Se guardo correctamente",tipo:"success", visitas:listVisitas}.to_json
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
        listVisitas=VisitaAuditor.select('VA.*,EMP.NOMBRE_EMPRESA,SUC.DESC_SUCURSAL,to_char(VA.FECHA_VISITA, \'DD/MM/YYYY\') FECHA_STR,to_char(VA.FECHA_VISITA,\'DD\') DIA').joins('VA  JOIN "seguridad"."EMPRESA" EMP ON EMP.ID_EMPRESA=VA.ID_EMPRESA  JOIN "seguridad"."SUCURSAL" SUC ON SUC.ID_SUCURSAL=VA.ID_SUCURSAL').where(" to_char(VA.FECHA_VISITA,'YYYY')='#{params[:year]}'  AND to_char(VA.FECHA_VISITA,'MM')='#{params[:mes]}' AND VA.id_usuario='#{session[:usuario_id]}'")
        respond_to do |format|           
            format.html 
            format.json do
                render json:{visitas:listVisitas}.to_json
             end
         end
    end

    def viewReportes    
        render 'reporteVisitas', layout: 'mailer'
    end

    
    def getReport
        
        query="SELECT count(1) cantidad FROM #{"\"seguridad\""}.#{"\"VISITA_AUDITOR\""}  WHERE fecha_visita between '#{params[:fechaInicio]}' and  '#{params[:fechaFin]}'"
        totalVisitas = ActiveRecord::Base.connection.execute(query)

        query="SELECT count(1) cantidad FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV JOIN #{"\"seguridad\""}.#{"\"VISITA_AUDITOR\""}  VA ON VA.ID_VISITA=NV.ID_VISITA  WHERE fecha_visita between '#{params[:fechaInicio]}' and  '#{params[:fechaFin]}'"
        totalNovedades = ActiveRecord::Base.connection.execute(query)
                
        query="SELECT count(1) cantidad FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV JOIN #{"\"seguridad\""}.#{"\"VISITA_AUDITOR\""}  VA ON VA.ID_VISITA=NV.ID_VISITA  WHERE fecha_visita between '#{params[:fechaInicio]}' and  '#{params[:fechaFin]}' and NV.ESTADO_NOVEDAD='Cerrada'"
        totalNovedadesR = ActiveRecord::Base.connection.execute(query)

        query="SELECT count(1) cantidad FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV JOIN #{"\"seguridad\""}.#{"\"VISITA_AUDITOR\""}  VA ON VA.ID_VISITA=NV.ID_VISITA  WHERE fecha_visita between '#{params[:fechaInicio]}' and  '#{params[:fechaFin]}' and (NV.ESTADO_NOVEDAD!='Cerrada' or NV.ESTADO_NOVEDAD is null)"
        totalNovedadesN = ActiveRecord::Base.connection.execute(query)

        #query="SELECT ceiling((CAST((SELECT count(1)  FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV JOIN #{"\"seguridad\""}.#{"\"VISITA_AUDITOR\""}  VA ON VA.ID_VISITA=NV.ID_VISITA WHERE fecha_visita between '#{params[:fechaInicio]}' and  '#{params[:fechaFin]}' and NV.ESTADO_NOVEDAD='Cerrada')AS FLOAT )/CAST((SELECT count(1)  FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV JOIN #{"\"seguridad\""}.#{"\"VISITA_AUDITOR\""}  VA ON VA.ID_VISITA=NV.ID_VISITA WHERE fecha_visita between '#{params[:fechaInicio]}' and  '#{params[:fechaFin]}' )AS FLOAT)*100)) porcentaje" 
        #porcentaje = ActiveRecord::Base.connection.execute(query)

        query="SELECT VA.*,SUC.DESC_SUCURSAL,EMP.NOMBRE_EMPRESA,(SELECT COUNT(1) FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV WHERE NV.ID_VISITA=VA.ID_VISITA) total_novedades, (SELECT COUNT(1) FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV WHERE NV.ID_VISITA=VA.ID_VISITA AND NV.ESTADO_NOVEDAD='Cerrada') total_novedades_resueltas, (SELECT COUNT(1) FROM #{"\"seguridad\""}.#{"\"NOVEDAD\""} NV WHERE NV.ID_VISITA=VA.ID_VISITA AND (NV.ESTADO_NOVEDAD!='Cerrada' or NV.ESTADO_NOVEDAD is null)) total_novedades_no FROM #{"\"seguridad\""}.#{"\"VISITA_AUDITOR\""} VA  INNER JOIN #{"\"seguridad\""}.#{"\"SUCURSAL\""} SUC ON SUC.ID_SUCURSAL=VA.ID_SUCURSAL  INNER JOIN #{"\"seguridad\""}.#{"\"EMPRESA\""} EMP ON EMP.ID_EMPRESA=VA.ID_EMPRESA  where VA.fecha_visita between '#{params[:fechaInicio]}' and  '#{params[:fechaFin]}'"
        listReporte=ActiveRecord::Base.connection.execute(query)


        respond_to do |format|           
            format.html 
            format.json do
                render json:{totalVisitas:totalVisitas,totalNovedades:totalNovedades,totalNovedadesR:totalNovedadesR,totalNovedadesN:totalNovedadesN,listReporte:listReporte}.to_json
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
