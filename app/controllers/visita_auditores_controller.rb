class VisitaAuditoresController < ApplicationController

    def index
        render 'index', layout: 'mailer'
    end


    def getInfo
        listVisitas=VisitaAuditor.select('VA.*,EMP.NOMBRE_EMPRESA,SUC.DESC_SUCURSAL,to_char(VA.FECHA_VISITA, \'DD/MM/YYYY\') FECHA_STR,to_char(VA.FECHA_VISITA,\'DD\') DIA').joins('VA  JOIN "seguridad"."EMPRESA" EMP ON EMP.ID_EMPRESA=VA.ID_EMPRESA  JOIN "seguridad"."SUCURSAL" SUC ON SUC.ID_SUCURSAL=VA.ID_SUCURSAL')
        respond_to do |format|           
            format.html 
            format.json do
                render json:{visitas:listVisitas}.to_json
             end
         end
    end
end
