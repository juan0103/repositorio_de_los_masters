$(document).ready(function() {
    validator();
    filterTable();
    
    $( "#btnClean" ).click(function() {//evento para limpiar formulario de registro
        clean();                      
    });
    
    $( "#btnRegister" ).click(function() {//evento para registrar o modificar un usuario
        if(Fmvalidators('grupo1')==true){   
           if($("#txtConfirm").val()!=$("#txtPass").val()){
             alertify.error("Las contraseñas no coinciden");
             return;
           }
           var dataRequest= {id:$("#txtId").val(),cedula:$("#txtCedula").val(),nombre:$("#txtNombre").val(),apellido:$("#txtApellido").val(),
                             login:$("#txtLogin").val(),password:$("#txtPass").val(),perfil:$('#slProfiles').val()};
           requestAjax('/users/save_register',dataRequest,'POST',saveRegister);           
           clean();
        }
    });
    
    
    $( document ).delegate( ".edit", "click", function() {//evento al presionar el boton de editar en alguna tabla
        showModal('ventana');//se levanta la ventana
        var $d = $(this).parent("td");
        var col = $d.parent().children().index($d);
        var row = $d.parent().parent().children().index($d.parent())+1;
        var Grid_Table = document.getElementById('tableUser');        
        $('#txtId').val(Grid_Table.rows[row].cells[0].textContent);
        $('#txtLogin').val(Grid_Table.rows[row].cells[1].textContent);
        $('#txtPass').val(Grid_Table.rows[row].cells[2].textContent);
        $('#txtConfirm').val(Grid_Table.rows[row].cells[2].textContent);
        $('#txtNombre').val(Grid_Table.rows[row].cells[3].textContent);
        $('#txtApellido').val(Grid_Table.rows[row].cells[4].textContent);
        $('#txtCedula').val(Grid_Table.rows[row].cells[5].textContent);
    });

    });
        
    window.addEventListener('load', function(){//Metodo para cargar los datos iniciales en la pantalla
        requestAjax('/users/getInfo',{},'GET',getInfoInicial);        
    }, 
    false);
    

    function clean(){//funcion para limpiar datos
        $("#txtId").val("");
        $("#txtCedula").val("");
        $("#txtNombre").val("");
        $("#txtApellido").val("");
        $("#txtLogin").val("");
        $("#txtPass").val("");
        $("#txtConfirm").val("");
        $('#slProfiles').val("");
    }

function getInfoInicial(jsonResponse){  //funcion para cargar la informacion inicial
 //console.log(jsonResponse); 
 getUsers(jsonResponse.users);
 getProfiles(jsonResponse.profiles);  
}

 function getUsers(jsonResponse){  //funcion para cargar los usuario
   $('#tableUser').DataTable().clear().draw();
  var table = $('#tableUser').DataTable();  
    for (i = 0; i < jsonResponse.length; i++) { //se llenan los perfiles           
            table.row.add( [jsonResponse[i].id,jsonResponse[i].login,jsonResponse[i].password,
                          jsonResponse[i].nombre,jsonResponse[i].apellido,jsonResponse[i].cedula,
                          "<button type='button' class='btn btn-success edit' ><i class='fa  fa-pencil' /></button>",
                          "<button type='button' class='btn btn-danger edit'  ><i class='fa   fa-remove' /></button>"]).draw(false);
        }                
}


function getProfiles(jsonResponse){//funcion para cargar los perfiles                 
        for (i = 0; i < jsonResponse.length; i++) {            
                $('#slProfiles').append($('<option>',{
                    value: jsonResponse[i].id,
                    text:  jsonResponse[i].descripcion
                }));
            }                
}


function saveRegister(jsonResponse){//funcion para registrar un usuario
   swal(jsonResponse.title,jsonResponse.mensaje,jsonResponse.tipo);
   if(jsonResponse.tipo=="success"){
      clean();
      getUsers(jsonResponse.users);
    }
}