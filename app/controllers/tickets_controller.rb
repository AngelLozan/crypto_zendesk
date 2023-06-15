class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :set_ticket, only: %i[show edit update assign]

  def index
    @tickets = Ticket.all
    @current_user = current_user
  end

  def show
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
      redirect_to chatroom_path(@chatroom)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def assign
    # IMPORTANT: Currently just for assigning self to ticket
    # @user = User.find(params[:user_id])
    # # If user params, assing to that user
    # # otherwise, assign to the current user
    if @ticket.update(user: current_user)
      @chatroom = @ticket.chatroom
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
    @ticket.update(params[:ticket])
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
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
