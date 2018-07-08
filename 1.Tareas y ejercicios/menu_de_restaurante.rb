#CASE
#El siguiente es el menú de un restaurante. Diseñar un algoritmo que según lo seleccionado lea el número de 
#unidades consumidas del alimento y calcule el total a pagar.
#Menú básico (1500) 
#Menú especial (3000) 
#Menú romántico (5000)

class Menu
    $subtotal=0
    $tarifa=0
    $i = 0
    def iniatialize
    end

  
    def seleccionarMenu
            while $i < 1 do
                puts "seleccione una opcion del menu"
                menu=["1 menu basico (1500)", "2 Menu especial (3000)", "3 Menu Romantico (5000), 4 cobrar"]
                menu.each do |elementos|
                    puts elementos
                end
                seleccion=gets.chomp.to_i
                case seleccion 
                    when 1 then $tarifa=1500
                    when 2 then $tarifa=3000
                    when 3 then $tarifa=5000
                    when 4 then cobrar()
                end
                puts "digite las unidades a consumir"
                unidades=gets.chomp.to_i
                $subtotal=$subtotal+($tarifa*unidades)
                puts "gracias por tu compra deseas comprar algo mas? 1=si 2=cobrar"
                volver=gets.chomp.to_i
                case volver
                    when 2 then cobrar(); $i=2
                end
            end
    end
    

    def cobrar
        puts "apreciado cliente el valor total a cancelar es de: #{$subtotal}"
    end

end
puts "Bienvenido a mi primer restaurante con Ruby"
objMenu= Menu.new  
objMenu.seleccionarMenu
gets()