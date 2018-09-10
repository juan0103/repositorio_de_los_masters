class VisitaAuditoresController < ApplicationController

    def index
        render 'index', layout: 'mailer'
    end


end
