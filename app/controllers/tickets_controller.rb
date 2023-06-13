class TicketsController < ApplicationController
<<<<<<< HEAD

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
=======
  before_action :set_ticket, only: %i[:show, :edit, :update, :assign]

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to chatroom_path(@ticket)
    else
      render :new
    end
  end

  def update
    # mark status (open, closed, assigned)
  end

  def assign
    
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(
      :client_email,
      :wallet_address,
      :content
    )
  end
end
>>>>>>> 5a5ad04e20b2c6d412e9ed9eaba342c01e45a5af
