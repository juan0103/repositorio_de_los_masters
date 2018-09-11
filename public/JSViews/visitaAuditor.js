$(document).ready(function() {




});

window.addEventListener('load', function(){//Metodo para cargar los datos iniciales en la pantalla
    requestAjax('/visita_auditores/getInfo',{},'GET',getInfoInicial);        
}, false);

function getInfoInicial(jsonResponse){  //funcion para cargar la informacion inicial
    console.log(jsonResponse); 
    //getCalendar(jsonResponse.visitas);    
 }