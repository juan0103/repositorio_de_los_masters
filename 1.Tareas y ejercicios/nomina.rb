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
        salario_basico=gets.chomp.to_i
        puts "ingrese horas extra"
        h_extra=gets.chomp.to_i
        puts "ingrese retencion por aportes"
        r_aportes=gets.chomp.to_i
        puts "cumplio con los 15 dias? 1=si 2=no"
        dias=gets.chomp.to_i
        case dias
        when 1 then pre=salario_basico+(h_extra*4068)-r_aportes+100000; imprimir_nomina(nombres,apellidos,pre)
        when 2 then pre=salario_basico+(h_extra*4068)-r_aportes-50000; imprimir_nomina(nombres,apellidos,pre)
        else puts "opcion no valida"; registrar_datos
        end
    end
    def imprimir_nomina nombres, apellidos, pre
        puts "\n"
        puts "\n"
        puts "nomina para el empleado: #{nombres} #{apellidos}"
        puts "salario neto a pagar #{pre}"
    end

end
objNominaEmpleado= NominaEmpleado.new
objNominaEmpleado.registrar_datos
gets()
#----------------------------------------------fin de nomina-------------------------------------------------------------------------------