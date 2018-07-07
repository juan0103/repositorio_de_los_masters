#Realice un algoritmo que permita revisar las notas de un alumno en el curso de opción de grado. 
#El alumno en total tiene 5 notas. Imprimir si aprobó o reprobó las notas, también debe contar las 
#ganadas y perdidas, imprimir al final cuantas gano y cuantas perdio. Se entiende como reprobado una 
#nota menor a 3.0
class hola
    def initialize
    end
    def calcularnotas 
        *nota
        puts "ingrese nota 1"
        nota[0]=gets.chomp.to_i
        puts "ingrese nota 2"
        nota[1]=gets.chomp.to_i
        puts "ingrese nota 3"
        nota[2]=gets.chomp.to_i
        puts "ingrese nota 4"
        nota[3]=gets.chomp.to_i
        puts "ingrese nota 5"
        nota[4]=gets.chomp.to_i
        i=1
        suma=0
        reprobadas=0
        aprobadas=0
        for i in nota
            suma=suma+nota[i]
            if nota[i]<3
                reprobadas=reprobadas+1
            elsif nota[i]>=3
                aprobadas=aprobadas+1
            end
        end
        promedio=suma/nota.length
        if promedio >= 3
            puts "el estudiante aprobo con una nota final de : #{promedio}"
            puts "obteniendo #{aprobadas} notas aprobadas y #{reprobadas} notas reprobadas"
        elsif promedio < 3
            puts "el estudiante reprobo con una nota final de : #{promedio}"
            puts "obteniendo #{aprobadas} notas aprobadas y #{reprobadas} notas reprobadas"
        end
    end
end

objnotas= hola.new
objnotas.calcularnotas
gets()

