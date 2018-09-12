$(document).ready(function() {
    validator();



});

function showModalRegister(idAccion){
    showModal('AgregarNovedad');
    document.getElementById("idAcion").value=idAccion;
 }