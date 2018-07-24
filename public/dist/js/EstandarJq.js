function validator(){
	$('.validator').keyup(function () {
	   if (!this.value == "") {            
		   this.style.border = "";
		   this.style.borderColor = ""
	   } 
   });
	   
   
   $('.validator').select(function () {
	if (!this.value == "") {            
		this.style.border = "";
		this.style.borderColor = ""
	} 
});
}

function positive(){
	$('.positive').keyup(function () {
        this.value = (this.value + '').replace(/[-]/g, '');
    });
}
 
function filterTable(){
	$('.filterTable').DataTable({
        "language": {
            "lengthMenu": "Ver _MENU_ Por Pagina",
            "zeroRecords": "Nothing found - sorry",
            "info": "Ver Pagina _PAGE_  De _PAGES_",
            "infoEmpty": "No hay resultados",
            "infoFiltered": "(filtered from _MAX_ total records)"
        }
    });
}
   

function datePicker(){
	$('.datePicker').datetimepicker();
}

function money(){
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
}
function number(ventana) {
	$('.number').numeric(",");
}
function showModal(ventana) {
    $('#' + ventana).modal();
}

function msgBasico(titulo, mensaje, tipo) { swal(titulo, mensaje, tipo); }

function validator(){
    $('.validator').keyup(function () {
        if (!this.value == "") {            
        this.style.border = "";
        this.style.borderColor = ""
        }   
    });
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
	 
     return response;
 }

function requestAjax(urlRequest,dataRequest,typeRequest,functionSuccess){
	$.ajax({        
		url : urlRequest,     
		data : dataRequest,    
		type : typeRequest,     
		dataType : 'json',     
		success :functionSuccess,     
		error : function(xhr, status) {						
			swal("Mensaje","Sucedio un error procesando su solicitud por favor intentelo de nuevo","error");
		},     
		complete : function(xhr, status) {     
			console.log("Peticion completada");           
		}
	});

}