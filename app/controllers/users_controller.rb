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
            render 'index'
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
     user=User.find(params[:id])
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



end 