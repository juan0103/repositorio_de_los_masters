
var fileByteArray = [];

window.addEventListener('load', function(){//Metodo para cargar los datos iniciales en la pantalla   
     requestAjax('/novedades/loadInformacion',{},'POST',function(jsonResponse){       
     console.log(jsonResponse);
     loadNovedades(jsonResponse.listFacturas,"tablenovedad");        
   });      
   
}, false);


function showModalRegister(idProceso,idNovedad,idTabla){
    cleanCampos();
    showModal('ModalCrear');
    document.getElementById("idProceso").value=idProceso;
    document.getElementById("idNovedad").value=idNovedad;
    document.getElementById("idTable").value=idTabla;
 }





function showModalUpdate(idProceso,idNovedad,idTabla,button,fila){
    showModalRegister(idProceso,idNovedad,idTabla);
    var $d = $(button).parent("td");
    var Grid_Table = document.getElementById(idTabla);        
    $('#selectInteresados').val(Grid_Table.rows[fila].cells[1].textContent);
    $('#selectTnovedad').val(Grid_Table.rows[fila].cells[3].textContent);
    $('#titulonovedad').val(Grid_Table.rows[fila].cells[5].textContent);
    $('#detallenovedad').val(Grid_Table.rows[fila].cells[6].textContent);        
 }



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