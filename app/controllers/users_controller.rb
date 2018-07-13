class UsersController < ApplicationController
    def index
        render 'index'
    end
    def login
        if User.exists?(:login=>params[:txtuser],:password=>params[:txtpassword])
           
            render 'home', layout: 'home'
            
        else
            @message = 'Usuario o contraseña incorrecta'
            @tipo="error"
            render 'index'
        end
    end
    def register
        @perfiles = Profile.all
        render 'register'
    end
    def saveregister
    mensaje=""
        if params.presence?(params[:txtLogin]) mensaje=mensaje+"ingrese login,"
        if params[:txtLogin].eql?("")  mensaje=mensaje+"ingrese login,"
        if params[:ddlPerfil].eql?("") mensaje=mensaje+"seleccione perfil,"
        if params[:txtPassword].eql?("") mensaje=mensaje+"ingrese password,"
        if params[:txtPassword].eql?(params[:txtConfirmarPassword]) mensaje=mensaje+"password no coincide,"

        user_search= User.order_by("id").last
        id = user_search.id +1
        user = User.new
        user.login = params[:txtLogin]
        user.password = params[:txtPassword]
        user.perfil_id= params[:ddlPerfil]

        if user.save?
    
        else
    
        end
    end

end

