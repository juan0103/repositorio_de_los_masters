
$( document ).ready(function() {
   $('.number').numeric(",");

    $('.positive').keyup(function () {
        this.value = (this.value + '').replace(/[-]/g, '');
    });

    $('.filterTable').DataTable({
        "language": {
            "lengthMenu": "Ver _MENU_ Por Pagina",
            "zeroRecords": "Nothing found - sorry",
            "info": "Ver Pagina _PAGE_  De _PAGES_",
            "infoEmpty": "No records available",
            "infoFiltered": "(filtered from _MAX_ total records)"
        }
    });


    $('.money').keyup(function () {
        var num = this.value.replace(/\./g, "");
        if (!isNaN(num)) {
            num = num.toString().split("").reverse().join("").replace(/(?=\d*\.?)(\d{3})/g, "$1.");
            num = num.split("").reverse().join("").replace(/^[\.]/, "");
            entrada = num;
        } else {
            entrada = input.value.replace(/[^\d\.]*/g, "");
        }

        this.value = entrada;
    });


    $('.validator').keyup(function () {
        if (!this.value == "") {            
			this.style.border = "";
            this.style.borderColor = ""
        } 
    });

});


function showModal(ventana) {
    $('#' + ventana).modal();
}

function msgBasico(titulo, mensaje, tipo) { swal(titulo, mensaje, tipo); }


function  fmConfirmar(texto){
    var resp = true;
    swal({
        title: "¿Deseas unirte al lado oscuro?",
        text: "Este paso marcará el resto de tu vida...",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "¡Claro!",
        cancelButtonText: "No, jamás",
        closeOnConfirm: false,
        closeOnCancel: false
    },

		function (isConfirm) {
		    if (isConfirm) {
		        swal("¡Hecho!",
					"Ahora eres uno de los nuestros",
					"success"); resp = true;
		    } else {
		        swal("¡Gallina!",
					"Tu te lo pierdes...",
				"error");
		    }
		});

     return resp;
 }



 function Fmvalidators(grupo){
     var response=true;	 
	 //se obtienen todos los controles requeiren validacion
	 $('.validator').each(function(key, element){         
	   var validaacionCampo=true;
	    if(element.getAttribute("group-validator")!=null && element.getAttribute("group-validator")==grupo){//si pertenecen al control de validacion
		   var valor;
		   if(element.getAttribute("requiredFm")!=null && element.getAttribute("requiredFm")=="true"){//si se debe valdiar que este lleno
			  valor=element.value;
			  if(valor == null || valor.length == 0 || /^\s+$/.test(valor)) {                 
			     response=false; 
				 validaacionCampo=false;
                 element.style.border = "1px solid red";
				 if(element.getAttribute("validatorMssg")!=null)
				    alertify.error(element.getAttribute("validatorMssg"));								
                }
		    }
			
			if(element.getAttribute("email")!=null && element.getAttribute("email")=="true" && validaacionCampo==true){//si paso la validacion de reque
          	   var emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;             				
			   if(!emailRegex.test(valor)) {
                  response = false;
				  element.style.border = "1px solid red";
				  if(element.getAttribute("validatorMssg")!=null)
					 alertify.error(element.getAttribute("validatorMssg"));								 
				}    
			
			}			
		   		   
		}		 
     });
	 /*
     var aux = true;
     //se obtiene un array de los controles a validar
     var arrayControles = controles.split(",");
     //se recorren los controles para validarlos
     for (x = 0; x < arrayControles.length; x++) {
     //obtenemos el id enviado para saber que tipo de validacion debe hacerce 
         var id = arrayControles[x]
         var valor;
         if(id.substring(id.length - 1, id.length) == '@') {
            //se obtiene el valor digitado           
			valor = document.getElementById(id.substring(0, id.length - 1)).value;
            emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
             
			//se valida si el texto corresponde al de un correo
			if (!emailRegex.test(valor)) {
                 aux = false;
                 document.getElementById(id.substring(0, id.length - 1)).style.border = "1px solid red";
             }
         }else{//en este caso es si se valida un campo de texto no valla vacio         
            //se obtiene el textboxt  
            valor=document.getElementById(arrayControles[x]).value;
             if(valor == null || valor.length == 0 || /^\s+$/.test(valor)) {
                aux = false;
                document.getElementById(master + arrayControles[x]).style.border = "1px solid red";
             }
         }
     }*/
     return true;
 }

