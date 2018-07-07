class Empleado
    @nombre_completo
    def initialize

    end

    def registrar_datos 
        puts "ingrese nombres"
        nombres=gets.chomp
        puts "ingrese apellidos"
        apellidos=gets.chomp
        puts "nombres: #{nombres} Apellidos: #{apellidos}"
        puts  @nombre_completo="nombre completo #{nombres}#{apellidos}"
    end

    def registrar_datos_adicionales *args
        if args[0] != nil and args[1] == nil
            puts "dato adicional: #{args[0]}"
        elsif args[1] != nil 
            puts "dato adicional: #{args[0]}"
            puts "dato telefono: #{args[1]}"
        end
    end

    def validar_password password
        bl_resultado= case password
        when 123 then "success administrator"
        when 456 then "success invitado"
        else "password incotrrect"
        end
        puts bl_resultado
    end
end

objEmpleado= Empleado.new
#objEmpleado.registrar_datos 
#objEmpleado.registrar_datos_adicionales 123456
objEmpleado.validar_password 123
gets()