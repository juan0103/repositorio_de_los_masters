$(document).ready(function() {
    validator();
      	
    $( "#btnBuscar" ).click(function() {//evento para el boton de consultar el calendario
        if(!Fmvalidators('grupo1'))
           return;
        createRowsCalendar();  
        $('#date').text($("#month option:selected" ).text()+" "+$("#year").val());         
        requestAjax('/visita_auditores/getInfo',{year:$("#year").val(),mes:$("#month").val()},'GET',printVisitasCalendar(jsonResponse));                        
    });

    $("#selectEmpresa").change(function() {//evento de seleccion empresa
       llenarSucursales();
    });

    $( "#btnRegister" ).click(function() {//registrar la visita
        if(!Fmvalidators('grupo2'))
           return;                   
        requestAjax('/visita_auditores/createVisita',{id_sucursal:$("#selectSucursal").val(),id_empresa:$("#selectEmpresa").val(), fecha_visita:$("#hiddenDay").val()+"/"+$("#hiddenMes").val()+$("#hiddenYear").val()},'POST',function(jsonResponse){
            swal(jsonResponse.title,jsonResponse.mensaje,jsonResponse.tipo);
            if(jsonResponse.tipo=="success"){
               cleanFields();
               printVisitasCalendar(jsonResponse);
             }
        });                        
    });

});

window.addEventListener('load', function(){//Metodo para cargar los datos iniciales en la pantalla
    //se cargan los años de la lista
    for (i = new Date().getFullYear(); i > 1900; i--){
        $('#year').append($('<option>',{ value: i, text:  i}));
    }

}, false);
function cleanFields(){        
    $('#selectSucursal').val('');
    $('#selectEmpresa').val('');
    $('#hiddenDay').val('');
    $('#hiddenMes').val('');
    $('#hiddenYear').val('');
}

//se envia el modal
function showModalCreate(day,month,year){
    $('#selectSucursal').empty().append('<option selected="selected" value="">Seleccionar..</option>');
    $('#selectEmpresa').val('');
    $('#hiddenDay').val(day);
    $('#hiddenMes').val(month);
    $('#hiddenYear').val(year);
    showModal('createVisita');
 }

 
//se crean los cuadros del calendario
 function createRowsCalendar(){
     var numDias=30;
     var html;     
     var numDiaAdd=1;
     $( ".fc-row " ).remove();       
     for (var i = 1; i <= 5; i++) { 
        html="";  
        html+=" <div class='fc-row fc-week fc-widget-content' style='height: 80px;'>";
          //se crean los encabezados para los calendarios
          html+=" <div class='fc-bg'>";
          html+=" <table> <tbody> <tr>";
          for (var j = 0; j < 6; j++) { 
            html+=" <td class='fc-day fc-widget-content fc-sun fc-other-month fc-past' ></td>";
          }
          html+=" </tr>  </tbody> </table> </div> ";
          //termino de encabezados para el calendario

          //inicia la creacion de valores para el calendario
          html+=" <div class='fc-content-skeleton'> ";
          html+=" <table> ";
          html+=" <tbody> <tr> ";
          for (var j = 0; j < 6; j++) { 
            if(numDiaAdd<=numDias){
                html+=" <td   id='td_"+numDiaAdd+"' class='fc-day-number fc-sun fc-today fc-state-highlight'>"+numDiaAdd;
                html+="<a id='btnadd_"+numDiaAdd+"' class='fc-day-grid-event fc-event fc-start fc-end fc-draggable' style='background-color:#fff;border-color:#fff'>";
                html+="<div class='fc-content'>";                    
                html+="<button  class='btn btn-primary'  data-toggle='tooltip' data-placement='top' title='Crear visita' onclick='showModalCreate(\""+numDiaAdd+"\",\""+$("#month").val()+"\",\""+$("#year").val()+"\");'> <i class='fa fa-plus-square'></i> </button>"                 
                html+="</div></a>";

                html+="<a  id='btnadd2_"+numDiaAdd+"' class='fc-day-grid-event fc-event fc-start fc-end fc-draggable' style='background-color:#00a65a;border-color:#fff'>";
                html+="<div class='fc-content'>";                    
                html+="Martes"                 
                html+="</div></a>";

                html+="</td>";
            }else {
                html+=" <td   class='fc-day-number fc-sun fc-today fc-state-highlight'></td>";
            }
                
            numDiaAdd++;
          }
          html+=" </tr>  </tbody> </table> </div> ";  
          $( "#containerCalendar" ).append(html);      
      }      
 }

 //se imprimen los datos del calendario 
 function printVisitasCalendar(jsonResponse){     
    for(i = 0; i < jsonResponse.visitas.length; i++) { //se recorren las visitas para posicionarlas en el calendario
        console.log("dia:"+jsonResponse.visitas[i].dia);
        var day=parseInt(jsonResponse.visitas[i].dia);              
        $("#btnadd_"+day).remove();  
        $("#btnadd2_"+day).remove();  
        var html="<a class='fc-day-grid-event fc-event fc-start fc-end fc-draggable' style='background-color:#fff;border-color:#fff'>";
        html+="<div class='fc-content'>";                    
        html+="<button  class='btn btn-warning'  data-toggle='tooltip' data-placement='top' title='Empresa:"+jsonResponse.visitas[i].nombre_empresa+"   Sucursal: "+jsonResponse.visitas[i].desc_sucursal+"' onclick='location.href =\"createnovedades?numVisita="+jsonResponse.visitas[i].id_visita+"\";'> <i class='fa fa-calendar-o'></i> </button>"            
        html+="</div></a>";
        html+="<a  id='btnadd2_"+day+"' class='fc-day-grid-event fc-event fc-start fc-end fc-draggable' style='background-color:#00a65a;border-color:#fff'>";
        html+="<div class='fc-content'>";                    
        html+="Martes"                 
        html+="</div></a>";
        $("#td_"+day).append(html);
        $("div").addClass("important");

    }
 }

 function llenarSucursales(){
    $('#selectSucursal').empty().append('<option selected="selected" value="">Seleccionar..</option>');
    if($( "#selectEmpresa" ).val()=='')
       return;
       requestAjax('/visita_auditores/getSucursales',{idEmpresa:$("#selectEmpresa").val()},'GET',function(jsonResponse){
           for (i = 0; i < jsonResponse.sucursales.length; i++) {
            $('#selectSucursal').append($('<option>',{ value: jsonResponse.sucursales[i].id_sucursal, text: jsonResponse.sucursales[i].desc_sucursal}));
           }
       });
 }