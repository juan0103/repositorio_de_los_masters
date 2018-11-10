$(document).ready(function() {
    validator();
    filterTable();
    datePicker();
    $( "#btnBuscar" ).click(function() {//evento para registrar o modificar un usuario                                      
        requestAjax('/visita_auditores/getReport',{fechaInicio:$("#fecha1").val(),fechaFin:$("#fecha2").val()},'GET',function(jsonResponse){         
           console.log(jsonResponse)
            $("#totalVisitas").empty();
            $("#totalVisitas").append(jsonResponse.totalVisitas[0].cantidad);

            $("#totalNovedades").empty();
            $("#totalNovedades").append(jsonResponse.totalNovedades[0].cantidad);

            $("#totalCompletadas").empty();
            $("#totalCompletadas").append(jsonResponse.totalNovedadesR[0].cantidad);

            $("#totalNoCompletados").empty();
            $("#totalNoCompletados").append(jsonResponse.totalNovedadesN[0].cantidad);

            var totalNov=jsonResponse.totalNovedades[0].cantidad;
            if(totalNov==0)
               totalNov=1;
            var efectividad=parseInt((jsonResponse.totalNovedadesR[0].cantidad/totalNov)*100);
            $("#porcentaje").empty();
            $("#porcentaje").append(efectividad+'%');


            $('#tableReport').DataTable().clear().draw();
             var table = $('#tableReport').DataTable(); 
            for(i = 0; i < jsonResponse.listReporte.length; i++) { //se llenan las novedades
                var totalNov=jsonResponse.listReporte[i].total_novedades;
                if(totalNov==0)
                   totalNov=1;                
                var efectividad=parseInt((jsonResponse.listReporte[i].total_novedades_resueltas/totalNov)*100);
                
                var colorEfectividad="#dd4b39";
                if(efectividad>49){
                    colorEfectividad="#00a65a";
                }
                
                var htmlEfectividad="<a class='c-day-grid-event fc-event fc-start fc-end fc-draggable' style='background-color:"+colorEfectividad+";border-color:#fff' >"+
                                "<div class='fc-content'>"+efectividad+"%</div></a>"
                

                var colorEstado="#dd4b39";
                if(jsonResponse.listReporte[i].estado=='Iniciada'){
                    colorEstado="#00a65a";
                }
                
                var htmlEstado="<a class='c-day-grid-event fc-event fc-start fc-end fc-draggable' style='background-color:"+colorEstado+";border-color:#fff' >"+
                                "<div class='fc-content'>"+jsonResponse.listReporte[i].estado+"</div></a>"
                
                
                table.row.add([jsonResponse.listReporte[i].id_visita,jsonResponse.listReporte[i].desc_sucursal,htmlEstado,
                jsonResponse.listReporte[i].total_novedades,jsonResponse.listReporte[i].total_novedades_resueltas,jsonResponse.listReporte[i].total_novedades_no,htmlEfectividad]).draw(false);                         
            }


        });                              
 });
    
});