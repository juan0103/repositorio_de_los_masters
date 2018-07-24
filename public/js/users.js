$(document).ready(function() {
   $("#btnGuardar").click(function() {
       $.ajax({
           url: 'users/save:_register_json',
           data: { 
               'login' :$('#login').val(),
               'perfil' :$('#perfil').val(),
               'password' :$('#password').val(),
               'nombre' :$('#nombre').val(),
               'apellido' :$('#apellido').val(),
               'cedula' :$('#cedula').val(),
               
                           },
           type: 'POST',
           dataType: 'json',
           success: function(json) {              
           },
           error: function(xhr, status) {
           }
       });
   });
});
