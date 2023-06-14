class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[:new]
  before_action :set_ticket, only: %i[:show, :edit, :update, :assign]

  def index
    @tickets = Ticket.all
  end


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
      render :new, status: :unprocessable_entity
    end
  end

  def assign
    # IMPORTANT: Currently just for assigning self to ticket
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
