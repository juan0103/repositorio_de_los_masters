#Algoritmo para realizar matrícula financiera, debe recibir información del 
#estudiante y valor del semestre , validar si tiene descuento (se realizará con S/N), 
#si tiene descuento te llevará a las siguientes opciones: 
#DESCUENTO DEL 20%
#DESCUENTO DEL 40 % 
#DESCUENTO DEL 50% 
class Matricula
    $valorsemestre=0.0
    def initialize
    end
    def matricularse
        puts "ingrese nombre"
        nombres=gets.chomp
        puts "ingrese apellidos"
        apellidos=gets.chomp
        puts "ingrese valor de semestre"
        $valorsemestre=gets.chomp.to_f
        puts "el estudiante tiene descuento? s=si n=no"
        comprobacion=gets.chomp
        if comprobacion=="s"
            descuentos = {'1= DESCUENTO DEL 20%'=> 0.2,'2= DESCUENTO DEL 40%' => 0.4, '3= DESCUENTO DEL 50%' => 0.5}
            descuentos.each do |key,value|
                puts "#{key}"
            end
            descuento=gets.chomp.to_f
            descuento2=0.0
            case descuento
            when 1.0 then descuento2=0.2
            when 2.0 then descuento2=0.4
            when 3.0 then descuento2=0.5
            end
            aplicar_descuento(descuento2, (nombres.concat(" "+apellidos)))
        elsif comprobacion=="n"
            aplicar_descuento(1, nombres.concat(" "+apellidos))
        end
    end
    def aplicar_descuento descontar, nombrecompleto
        puts "señor #{nombrecompleto} el valor a pagar es de: #{$valorsemestre-($valorsemestre*descontar)}"
    end
    objmatricula= Matricula.new
    objmatricula.matricularse
    gets()
end