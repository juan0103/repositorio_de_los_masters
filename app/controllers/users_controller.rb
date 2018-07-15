class UsersController < ApplicationController
    def index
        render 'index', layout: 'application'
    end
    def login
        if User.exists?(:login=>params[:txtuser],:password=>params[:txtpassword])
           
            render 'home', layout: 'home'
            
        else
            @message = "Usuario o contraseña incorrecta"
            @tipo="error"
            render 'index'
        end
    end
    def register
        @perfiles = Profile.all
        render 'register'
    end
    def save_register
        @perfiles = Profile.all
        mensaje=''
        if params[:txtnombre].strip.empty?
            mensaje += 'ingrese nombres,'
        end
        if params[:txtapellidos].strip.empty?
            mensaje += 'ingrese apellidos,'
        end
        if params[:txtcedula].strip.empty?
            mensaje += 'ingrese cedula,'
        end
        if params[:fecha].eql?('')
            mensaje += 'ingrese fecha de ingreso,'
        end
        if params[:txtlogin].strip.empty?
            mensaje += 'ingrese login,'
        end
        if params[:ddlPerfiles].empty?
             mensaje += 'seleccione perfil,'
        end
        if params[:txtpassword].strip.empty?
             mensaje += 'ingrese password,'
        end
        if !params[:txtpassword].strip.eql?(params[:txtConfirmarPassword].strip) 
            mensaje += 'password no coincide,'
        end
        if !mensaje.eql?('')
            @mensaje=mensaje.slice 0..-2
            @tipo = 'error'
            render 'register'
        else 
            save_2()
        end
    end
           def save_2 
        
        user = User.new
        user.id = User.maximum('id')+1
        user.nombre = params[:txtnombre]
        user.apellido = params[:txtapellidos]
        user.cedula = params[:txtcedula]
        user.fecha_ingreso = params[:fecha]
        user.login = params[:txtlogin]
        user.password = params[:txtpassword]
        user.perfil_id= params[:ddlPerfiles]
        if (user.save==true)
            @mensaje = "se realizo proceso con exito"
            @tipo = "success"
            render  'register' 
        else
            @mensaje = "hubo un error durante el procedimiento"
            @tipo = "error"
            render 'register'
        end
    end
        
   
    

end

