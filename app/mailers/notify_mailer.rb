class NotifyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  # 
  #   en.notify_mailer.send_mail.subject
 

  @codigo=''
  @id_usuario='0'

  def send_mail to_user
    datos=User.where(:login => to_user)                 #primero guardo en datos toda la info del usuario para usarla

    @id_usuario=datos[0].id                             # saco en @id_usuario el identificador de mi usuario
    @email=datos[0].email                               #saco en @email el correo a donde enviare el link de restauracion
    puts @id_usuario
    puts @email
    @Newrestore = RestorePassword.new                    #creo un objeto para usar la tabla RESTORE_PASSWORD
          @Newrestore.id_usuario=@id_usuario             #inserto en la tabla el id del usuario que solicito el reestablecimiento
          @Newrestore.codigo_url = RestorePassword.maximum('codigo_url')+1 #envio un codigo de restablecimiento para llevar un control
    @Newrestore.save                                     #guardo las sentencias para la tabla RESTORE_PASSWORD y ejecuto la insercion

    res=RestorePassword.where(:id_usuario => @id_usuario) 
    @codigo=res[0].codigo_url                            #saco el odigo generado para enviarlo en el link
    
 

    codigostring=@codigo.to_s
    @greeting=''
    @greeting='Hemos recibido una solicitud de restablecimiento de contraseña asociada a esta dirección de correo electrónico. Si has realizado esta solicitud, sigue las siguientes instrucciones.
    Para restablecer la contraseña de tu cuenta, simplemente tienes que hacer clic en el siguiente vínculo.
    http://localhost:3000/users/restaurarkey?codigo='+codigostring+'
    Este vínculo te dirigirá a una página Web en la que podrás establecer una nueva contraseña. 
    Ten en cuenta que el vínculo caducará en 24 horas a partir del momento en el que se envió este correo electrónico. Si el vínculo no funciona cuando haces clic en él, puedes copiarlo y pegarlo en la barra de direcciones del navegador. 
    Ha sido un placer ayudarte.'
    mail(to: @email, subject: 'Restauracion de Contraseña')
  end

  def send_mail_register to_user
    @greeting=''
    @greeting='Te damos la bienvenida a la plataforma 
    Hola! #####
    
    Gracias por registrar tus datos.'
    mail(to: @email, subject: 'Bienvenido!')
  end

end
