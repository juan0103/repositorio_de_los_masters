#Algoritmo para calcular la nómina de un trabajador, se debe tener en cuenta nombres y apellidos ,salario básico, horas extras, 
#y retención por aportes, si el trabajador laboró los 15 días entonces tiene derecho a 100.000 pesos por asistencia y cumplimiento; 
#si no se le descontará 50.000 por incumplimiento, imprimir por pantalla la información del trabajador y el valor neto a pagar.
#----------------------------------------------nomina-------------------------------------------------------------------------------
class NominaEmpleado
    def initialize
    end
    def registrar_datos 
        puts "ingrese nombres"
        nombres=gets.chomp
        puts "ingrese apellidos"
        apellidos=gets.chomp
        puts "ingrese salario basico"
        salario_basico=gets.chomp
        salario_basico=salario_basico.to_i
        puts "ingrese horas extra"
        h_extra=gets.chomp
        h_extra=h_extra.to_i
        puts "ingrese retencion por aportes"
        r_aportes=gets.chomp
        r_aportes=r_aportes.to_i
        puts "cumplio con los 15 dias? 1=si 2=no"
        dias=gets.chomp
        dias=dias.to_i
        if dias==1 
            pre=salario_basico+(h_extra*4068)-r_aportes+100000
        elsif dias==2
            pre=salario_basico+(h_extra*4068)-r_aportes-500000
            puts pre
        end
        puts "nomina para el empleado: #{nombres} #{apellidos}"
        puts "salario neto a pagar #{pre}"
    end
end
objNominaEmpleado= NominaEmpleado.new
objNominaEmpleado.registrar_datos
gets()
#----------------------------------------------fin de nomina-------------------------------------------------------------------------------