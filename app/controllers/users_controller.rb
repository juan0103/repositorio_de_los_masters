class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

   def initialize        
    @perfiles = Profile.all
    @listUsers = User.all
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
            render 'users', layout: 'mailer'
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

        if (user.save==true)
            respond_to do |format|           
               format.html 
               format.json do
                render json:{title: "Registro", mensaje:"Registro Exitoso",tipo:"success",users:User.all}.to_json
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
       
 
    def getInfo
        respond_to do |format|           
            format.html 
            format.json do
                render json:{users:User.all,profiles:Profile.all}.to_json
             end
         end
    end

    def restorekey 
        NotifyMailer.send_mail(params[:txtusuario]).deliver
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