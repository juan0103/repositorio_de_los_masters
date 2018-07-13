Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "users" => "users#index" # crea un alias y con la asignacion indico controlador y accion
  post "users/login" #indico directo el controlador y la accion
end
