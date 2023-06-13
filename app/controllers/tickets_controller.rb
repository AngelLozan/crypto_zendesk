class TicketsController < ApplicationController
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
    # Need to get id of user to assign and ticket
    # if condition
    # mark status
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
