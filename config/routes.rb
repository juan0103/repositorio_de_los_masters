Rails.application.routes.draw do
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
 
end
