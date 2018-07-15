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
            puts "#{@mensaje}"
            @tipo = 'error'
            render 'register'
        else 
            save_2()
        end
    end
           def save_2 
            puts "entro al dos"
        user = User.new
        user.id = User.maximum('id')+1
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

