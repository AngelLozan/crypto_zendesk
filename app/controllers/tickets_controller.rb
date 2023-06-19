class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :set_ticket, only: %i[show edit update assign]

  def index
    @tickets = Ticket.all.page params[:page]
    @current_user = current_user
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      @chatroom = Chatroom.new
      @chatroom.ticket = @ticket
      @chatroom.save
      redirect_to chatroom_path(@chatroom.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def assign
    if @ticket.update(user: current_user)
      @chatroom = @ticket.chatroom
      @ticket.update(status: 1)
      redirect_to chatroom_path(@chatroom)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update(ticket_params)
    redirect_to tickets_path
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
    @current_user = current_user
    # if @ticket.nil?
    # end
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
      :status,
      :subject
    )
  end
end
