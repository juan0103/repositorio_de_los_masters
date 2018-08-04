class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

   def initialize            
   end
   
    def index
        render 'index', layout: 'application'
    end
   
    def login
        if User.exists?(:login=>params[:txtuser],:password=>params[:txtpassword])        
            render 'home', layout: 'mailer'            
        else
            @message = "Usuario o contraseña incorrecta"
            @tipo="error"
            render 'index', layout: 'application'
        end
    end

    def register
        render 'register'
    end

    def save_register
    
   
       if(params[:id]!=nil and  !params[:id].eql?(""))
          user=User.find(params[:id])
       else
          user = User.new         
          user.id = User.maximum('id')+1
       end                
        user.login = params[:login]
        user.password = params[:password]
        user.nombre=params[:nombre ]
        user.apellido=params[:apellido]
        user.cedula=params[:cedula]
        user.perfil_id=params[:perfil]
        user.email=params[:email]
        cuerpoemail='Te damos la bienvenida a la plataforma 
        Hola! #####
        recuerda que tus datos para la plataforma son:
        usuario: '+user.login+'
        nombre: '+user.nombre+'
        appellido: '+user.apellido+'
        numero de cedula: '+user.cedula+'
        Gracias por registrar tus datos.'
        if (user.save==true)
            NotifyMailer.send_mail(params[:email], 'BIENVENIDO!', cuerpoemail).deliver
            listUsers=User.select('tbU.*,tbP.descripcion perfil,tbP.id perfilId').joins('tbU JOIN "seguridad"."tbperfil"  tbP ON tbP.id=tbU.perfil_id')  
            respond_to do |format|           
               format.html 
               format.json do
                render json:{title: "Registro", mensaje:"Se guardo correctamente",tipo:"success",users:listUsers}.to_json
                end
            end
        else
            respond_to do |format|           
                format.html 
                format.json do
                    render json:{title: "Error", mensaje:"Sucedio un Problema Procesando su solictud por favor intentelo de nuevo",tipo:"error"}.to_json
                 end
             end
        end
    end
       
    def delete_user
     user=User.find(params[:txtId])
     user.destroy()
     listUsers=User.select('tbU.*,tbP.descripcion perfil,tbP.id perfilId').joins('tbU JOIN "seguridad"."tbperfil"  tbP ON tbP.id=tbU.perfil_id')  
     respond_to do |format|           
        format.html 
        format.json do
            render json:{title: "Elimino", mensaje:"Se elimino correctamente el registro",tipo:"success",users:listUsers}.to_json
           end
        end
    end
 
    def getInfo
        listUsers=User.select('tbU.*,tbP.descripcion perfil,tbP.id perfilId').joins('tbU JOIN "seguridad"."tbperfil"  tbP ON tbP.id=tbU.perfil_id')
        respond_to do |format|           
            format.html 
            format.json do
                render json:{users:listUsers,profiles:Profile.all}.to_json
             end
         end
    end

    def restorekey 
    #consulta de datos necesarios para enviar el correo al usuario  
        @codigo=''
        @id_usuario='0' 
        atos=User.where(:login => params[:txtusuario]) #primero guardo en datos toda la info del usuario para usarla
        @id_usuario=datos[0].id                             # saco en @id_usuario el identificador de mi usuario
        @email=datos[0].email                               #saco en @email el correo a donde enviare el link de restauracion
        @Newrestore = RestorePassword.new                    #creo un objeto para usar la tabla RESTORE_PASSWORD
            @Newrestore.id_usuario=@id_usuario             #inserto en la tabla el id del usuario que solicito el reestablecimiento
            @Newrestore.codigo_url = RestorePassword.maximum('codigo_url')+1 #envio un codigo de restablecimiento para llevar un control
        @Newrestore.save                                     #guardo las sentencias para la tabla RESTORE_PASSWORD y ejecuto la insercion
        res=RestorePassword.where(:id_usuario => @id_usuario) 
        @codigo=res[0].codigo_url                            #saco el odigo generado para enviarlo en el link
        codigostring=@codigo.to_s
        cuerpo='Hemos recibido una solicitud de restablecimiento de contraseña asociada a esta dirección de correo electrónico. Si has realizado esta solicitud, sigue las siguientes instrucciones.
        Para restablecer la contraseña de tu cuenta, simplemente tienes que hacer clic en el siguiente vínculo.
        http://localhost:3000/users/restaurarkey?codigo='+codigostring+'
        Este vínculo te dirigirá a una página Web en la que podrás establecer una nueva contraseña. 
        Ten en cuenta que el vínculo caducará en 24 horas a partir del momento en el que se envió este correo electrónico. Si el vínculo no funciona cuando haces clic en él, puedes copiarlo y pegarlo en la barra de direcciones del navegador. 
        Ha sido un placer ayudarte.'
    #una vez que ya tengo los datos email con el codigo generado y todo, llamo la acccion que envia el correo
        NotifyMailer.send_mail(@email, 'Restauracion de Contraseña', cuerpo ).deliver
        @message = "Por favor revise el correo que le ha sido enviado"
        @tipo="success"
        render 'index', layout: 'application'
    end

    def insertpass
        usuario_code=RestorePassword.where(:codigo_url => params[:code])                 
        @id_usuario_code=usuario_code[0].id_usuario       
        User.update(@id_usuario_code, :password => params[:txtcontraseña])
        @message = "Su contraseña ha sido reestablecida correctamente"
        @tipo="success"                  
        render 'index', layout: 'application'
    end
end 