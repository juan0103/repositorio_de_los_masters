
var fileByteArray = [];

window.addEventListener('load', function(){//Metodo para cargar los datos iniciales en la pantalla   
     requestAjax('/novedades/getnovedades',{},'POST',function(jsonResponse){       
     console.log(jsonResponse);
     loadNovedades(jsonResponse.listnovedades, 'tablenovedad');
   });      
   
}, false);

/**metodo para visualizar el modal previo a un regsitro de novedad*/
function showModalRegister(autor,fecha,tnovedad,estado,detalle,idTabla){
    cleanCampos();
    showModal('ModalCrear');
    document.getElementById("Autor").innerHTML = autor;
    document.getElementById("Fecha").innerHTML=fecha;
    document.getElementById("TNovedad").innerHTML=tnovedad;
    document.getElementById("Estado").innerHTML=estado;
    document.getElementById("descripcion").innerHTML=detalle;
 }

/**metodo para visualizar el modal en edicion */
function showModalUpdate(autor,fecha,tnovedad,estado,detalle,idTabla,button,fila){
    showModalRegister(autor,fecha,tnovedad,estado,detalle,idTabla);
    var $d = $(button).parent("td");
    var Grid_Table = document.getElementById(idTabla);        
    $('#Autor').val(Grid_Table.rows[fila].cells[1].textContent);
    $('#selectTnovedad').val(Grid_Table.rows[fila].cells[3].textContent);
    $('#titulonovedad').val(Grid_Table.rows[fila].cells[5].textContent);
    $('#detallenovedad').val(Grid_Table.rows[fila].cells[6].textContent);        
 }

 function cleanCampos(){
    // document.getElementById("idProceso").value='';
     document.getElementById("Autor").innerHTMl='';
     document.getElementById("Fecha").innerHTMl='';
     document.getElementById("TNovedad").innerHTMl='';
     document.getElementById("Estado").innerHTMl='';
     document.getElementById("descripcion").innerHTMl='';
    
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
        var onclick1="onclick=\"showModalUpdate('"+jsonResponse[i].nombre+"', '"+jsonResponse[i].fecha_visita+"', '"+jsonResponse[i].desc_tnovedad+"', '"+jsonResponse[i].estado_novedad+"', '"+jsonResponse[i].detalle_novedad+"','"+idTabla+"',this,"+(i+1)+");\" ";          
        
        
        var colorEstado="";
        if(jsonResponse[i].estado_novedad=='Cerrado')
           colorEstado="#F92C00";
        else if(jsonResponse[i].estado_novedad=='Abierto') 
            colorEstado="#00a65a";

        var estado="<a   class='fc-day-grid-event fc-event fc-start fc-end fc-draggable' style='background-color:"+colorEstado+";border-color:#fff'>";
        estado+="<div class='fc-content'>";                    
        estado+=jsonResponse[i].estado_novedad;                 
        estado+="</div></a>";
        var row="<tr><td>"+jsonResponse[i].nombre+"</td><td>"+jsonResponse[i].titulo+"</td><td>"+jsonResponse[i].desc_tnovedad+"</td><td>"+jsonResponse[i].estado_novedad+"</td><td>"+
        jsonResponse[i].nombre_empresa+"</td><td>"+jsonResponse[i].desc_sucursal+"</td><td>"+jsonResponse[i].fecha_visita+"</td><td>"+
        "<button type='button' class='btn btn-xs btn-success edit' "+onclick1+" \" ><i class='fa  fa-pencil' /></button>";
        $(idTablaQ+' tr:last').after(row);         
       }
      
     
}