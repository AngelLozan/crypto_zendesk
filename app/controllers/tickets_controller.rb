class TicketsController < ApplicationController
<<<<<<< HEAD
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
=======
  before_action :set_ticket, only: %i[:index, :show, :edit, :update, :assign]

  def index
    @tickets = Ticket.all
  end
>>>>>>> 8ea7fb52116b70d177542102f5071ba74ef73911

  def show
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

  def assign
    # @user = User.find(params[:user_id])
    # # If user params, assing to that user
    # # otherwise, assign to the current user
    @ticket.user = current_user
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update(params[:ticket])
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(
      :client_email,
      :wallet_address,
      :content,
      :status
    )
  end
end
<<<<<<< HEAD
>>>>>>> 5a5ad04e20b2c6d412e9ed9eaba342c01e45a5af
=======
>>>>>>> 8ea7fb52116b70d177542102f5071ba74ef73911
