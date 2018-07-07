#Realice un algoritmo que permita revisar las notas de un alumno en el curso de opción de grado. 
#El alumno en total tiene 5 notas. Imprimir si aprobó o reprobó las notas, también debe contar las 
#ganadas y perdidas, imprimir al final cuantas gano y cuantas perdio. Se entiende como reprobado una 
#nota menor a 3.0
class Estudiantes
    def initialize
    end
    def calcularnotas 
        nota=[]
        for i in (0..4)
            puts "ingrese nota #{i+1}"
            nota[i]=gets.chomp.to_i
        end
        suma=0
        reprobadas=0
        aprobadas=0
        nota.each do |elemento|
            suma=suma+elemento
            if elemento<3
                reprobadas=reprobadas+1
            elsif elemento>=3
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
objnotas= Estudiantes.new
objnotas.calcularnotas
gets()

