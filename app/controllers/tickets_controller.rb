class TicketsController < ApplicationController

    def index
     @tickets =Ticket.all
    end

    def edit 
     @ticket = Ticket.find(params[:id])

    end

    def update 
     @ticket = Ticket.find(params[:id])
     @ticket.update(params[:ticket])
    end
end