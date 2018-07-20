class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

   def initialize
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
            render 'index'
        end
    end

    def register
        @perfiles = Profile.all
        render 'register'
    end

    def save_register
        @perfiles = Profile.all
        
        user = User.new
        user.id = User.maximum('id')+1
        user.login = params[:txtLogin]
        user.password = params[:txPassword]
        if (user.save==true)
            @mensaje = "se realizo proceso con exito"
            @tipo = "success"
            render  'home', layout:"home" 
        else
            @mensaje = "hubo un error durante el procedimiento"
            @tipo = "error"
            render  'home', layout:"home"
        end
    end
       
    def prueba
        respond_to do |format|            
            format.json { mensaje:"mensaje" }
        end
    end

end