Rails.application.routes.draw do
  resources :interesados
  resources :tipo_de_novedades
  resources :empresas
  resources :pais
  resources :branch_offices
  resources :countries
  resources :profiles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "users" => "users#index" # crea un alias y con la asignacion indico controlador y accion
  post "users/login" #indico directo el controlador y la accion
  post "users/save_register"
  get "users/register"
  post "users/prueba"
  get "users/getInfo"
  post "users/restorekey"
  get "users/restaurarkey"
  post "users/insertpass"
  get "index" => "landing_pages#index"
  post "users/delete_user"
  get "novedades" => "novedades#index"
  get "createnovedades" => "novedades#createnovedad"
  post "novedades/getnovedades"
  post "novedades/insertNovedad" 
  post "novedades/loadInformacion"
  post "novedades/delete_novedad"
  get "images" => "imagenes#index"


  get "visita_auditores" => "visita_auditores#index" # crea un alias y con la asignacion indico controlador y accion
  get "visita_auditores/getInfo" 

end
