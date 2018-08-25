class NovedadesController < ApplicationController
    def initialize            
    end
    def index
        render 'viewnovedades', layout: 'mailer'
    end
   def getnovedades
   end
end
