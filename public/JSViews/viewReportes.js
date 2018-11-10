$(document).ready(function() {
    validator();

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

            $("#porcentaje").empty();
            $("#porcentaje").append(jsonResponse.porcentaje[0].porcentaje+'%');
        });                              
 });
    
});