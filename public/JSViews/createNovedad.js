$(document).ready(function() {
    validator();
 
    $( "#btnRegister" ).click(function() {//evento para registrar o modificar un usuario                      
           var dataRequest= {id_novedad:$("#idNovedad").val(),detallenovedad:$("#detallenovedad").val(),interesado:$("#selectInteresados").val(),
           selectTnovedad:$("#selectTnovedad").val(),proceso:$("#idProceso").val(),titulo:$("#titulonovedad").val(),numVisita:$("#idNumVisita").val()};
           requestAjax('/novedades/insertNovedad',dataRequest,'POST',function(jsonResponse){
            swal(jsonResponse.title,jsonResponse.mensaje,jsonResponse.tipo);
            if(jsonResponse.tipo=="success"){
               cleanCampos();
               loadNovedades(jsonResponse.list,$("#idTable").val());               
             }   
             console.log(jsonResponse);
           });                              
    });

    
    $( "#myBtn" ).click(function() {
        //var myFile = $('#myInput').prop('files');
        //console.log(myFile);
        var files = myInput.files[0];
        var reader = new FileReader();
        reader.onload = processFile(files);
        reader.readAsArrayBuffer(files);
        //console.log(reader)
        /*var fileReader = new FileReader();
        fileReader.onload = function () {
          var data = fileReader.result;  // data <-- in this var you have the file data in Base64 format          
        };
        fileReader.readAsDataURL($('#myInput').prop('files')[0]);
        console.log(fileReader);
        //requestAjax('/novedades/save_image',{image:fileReader},'POST',function(jsonResponse){});*/
});


});
var fileByteArray = [];
function processFile(theFile){
    return function(e) { 
      var theBytes = e.target.result; //.split('base64,')[1]; // use with uploadFile2
      //fileByteArray.push(theBytes);
      console.log(theBytes);
      requestAjax('/novedades/save_image',{bytes:theBytes,id_novedad:18},'POST',function(jsonResponse){
           //console.log(jsonResponse.respuesta);

      });           
    }
  }

window.addEventListener('load', function(){//Metodo para cargar los datos iniciales en la pantalla     
  requestAjax('/novedades/loadInformacion',{numVisita:$("#idNumVisita").val()},'POST',function(jsonResponse){             
     console.log(jsonResponse);
     loadNovedades(jsonResponse.listFacturas,"tableEstaPagos");
     loadNovedades(jsonResponse.listImpuestos,"tableImpuesto");      
     loadNovedades(jsonResponse.listSanidad,"tableSanidad");
     loadNovedades(jsonResponse.listDian,"tableDian");
     loadNovedades(jsonResponse.listFisicoTerreno,"tableFisicoTerreno");
     loadNovedades(jsonResponse.listFisicoActivo,"tableFisicoActivo"); 
     loadNovedades(jsonResponse.listProductos,"tableProducto");  
     loadNovedades(jsonResponse.listaReporteHoras,"tableReporteHoras");  
     loadNovedades(jsonResponse.listCargoEmp,"tableCargoAsignadoEmpleado");  
     loadNovedades(jsonResponse.listConformidadEmpleado,"tableConformidadEmpleado");
     loadNovedades(jsonResponse.listSalidasEmergencia,"tableSalidasEmergencia"); 
     loadNovedades(jsonResponse.listFuegoEstab,"tableFuegoEstab");
     loadNovedades(jsonResponse.listIncendios,"tableIncendios");
     loadNovedades(jsonResponse.listPersonalCapacitado,"tablePersonalCapacitado");          
   });      
   
}, false);

function deleteNovedad(idNovedad,idTable){//metodo para eliminar una noverdad
        requestAjax('/novedades/delete_novedad',{id_novedad:idNovedad,numVisita:$("#idNumVisita").val()},'POST',function(jsonResponse){       
        swal(jsonResponse.title,jsonResponse.mensaje,jsonResponse.tipo);
        if(jsonResponse.tipo=="success"){           
           loadNovedades(jsonResponse.list,idTable);               
         }   
        
     }); 
}

/**metodo para visualizar el modal previo a un regsitro de novedad*/
function showModalRegister(idProceso,idNovedad,idTabla){
    cleanCampos();
    showModal('AgregarNovedad');
    document.getElementById("idProceso").value=idProceso;
    document.getElementById("idNovedad").value=idNovedad;
    document.getElementById("idTable").value=idTabla;
 }

/**metodo para visualizar el modal en edicion */
function showModalUpdate(idProceso,idNovedad,idTabla,button,fila){
    showModalRegister(idProceso,idNovedad,idTabla);
    var $d = $(button).parent("td");
    var Grid_Table = document.getElementById(idTabla);        
    $('#selectInteresados').val(Grid_Table.rows[fila].cells[1].textContent);
    $('#selectTnovedad').val(Grid_Table.rows[fila].cells[3].textContent);
    $('#titulonovedad').val(Grid_Table.rows[fila].cells[5].textContent);
    $('#detallenovedad').val(Grid_Table.rows[fila].cells[6].textContent);        
 }


 /**limpiar los comapos de modal*/
function cleanCampos(){
   // document.getElementById("idProceso").value='';
    document.getElementById("idNovedad").value='';
    document.getElementById("selectInteresados").value='';
    document.getElementById("selectTnovedad").value='';
    document.getElementById("titulonovedad").value='';
    document.getElementById("detallenovedad").value='';
}

/**consultar la informacion de las novedades registradas en el proceso*/
function loadNovedades(jsonResponse,idTabla){  
    var idTablaQ='#'+idTabla;
    
    /**se elimina las filas de la tabla
     */
    var lenght=document.getElementById(idTabla).rows.length;
    for(i = lenght-1; i >0 ; i--){        
        document.getElementById(idTabla).deleteRow(i);
    }     

    //$(idTablaQ+' tbody tr').remove(); 
    for(i = 0; i < jsonResponse.length; i++) { //se llenan las novedades
        var onclick1="onclick=\"showModalUpdate('"+jsonResponse[i].id_proceso_auditoria+"', '"+jsonResponse[i].id_novedad+"','"+idTabla+"',this,"+(i+1)+");\" ";          
        var onclick2="onclick=\"deleteNovedad('"+jsonResponse[i].id_novedad+"', '"+idTabla+"');\" ";          
        
        var row="<tr><td>"+jsonResponse[i].id_novedad+"</td><td>"+jsonResponse[i].id_interesado+"</td><td>"+jsonResponse[i].desc_interesado+"</td><td>"+jsonResponse[i].id_tipo_novedad+"</td><td>"+
        jsonResponse[i].id_tipo_novedad+"</td><td>"+jsonResponse[i].titulo+"</td><td>"+jsonResponse[i].detalle_novedad+"</td><td>"+""+"</td><td>"+
        "<button type='button' class='btn btn-sm btn-success edit' "+onclick1+" \" ><i class='fa  fa-pencil' /></button>"+"</td><td>"+
        "<button type='button' class='btn btn-sm btn-danger delete' "+onclick2+"><i class='fa   fa-remove' /></button></tr>";
        $(idTablaQ+' tr:last').after(row);         
       }
      
     if(jsonResponse.length>0){//en caso de tener registros se oculta en mensaje de no hay novedades 
        document.getElementById(idTabla+"Notify").style.display = "none"; 
        document.getElementById(idTabla).style.display = ""; 
     }else{//en caso de no tener registros se oculta la tabla de datos
        document.getElementById(idTabla+"Notify").style.display = ""; 
        document.getElementById(idTabla).style.display = "none"; 
     }
}