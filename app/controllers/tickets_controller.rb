require 'pry-byebug'

class TicketsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :set_ticket, only: %i[show edit update assign]
  helper_method :sort_column, :sort_direction

  def index
    @tickets = Ticket.all.order(updated_at: :desc).page params[:page]
    if params[:sort].present?
      @tickets = Ticket.all.order(sort_column + " " + sort_direction).page params[:page]
    end
    @current_user = current_user
    if params[:query].present?
      sql_subquery = <<~SQL
        users.first_name ILIKE :query
        OR users.last_name ILIKE :query
        OR tickets.wallet_address ILIKE :query
      SQL
      @tickets = @tickets.joins(:user).where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  # def list
  #   @tickets = Ticket.includes(:Assignee)
  #   @tickets = @tickets.where('name ilike ?', "%#{params[:name]}%") if params[:name].present?
  #   @tickets = @tickets.order("#{params[:column]} #{params[:direction]}")
  #   render(partial: 'tickets', locals: { tickets: @tickets })
  # end


  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      @chatroom = Chatroom.new
      @chatroom.secret_url = @chatroom.generate_secret
      @chatroom.ticket = @ticket
      # binding.pry
      @chatroom.save
      TicketMailer.secret(@ticket).deliver_later # Email user the secret chat
      flash[:notice] = "Thanks for creating a ticket!"
      redirect_to chatroom_path(@chatroom.secret_url)

    else
      render :new, status: :unprocessable_entity
    end
  end

  def assign
    if @ticket.update(user: current_user)
      @chatroom = @ticket.chatroom
      @ticket.update(status: 1)
      flash[:notice] = "The ticket was assigned to you!"
      redirect_to chatroom_path(@chatroom.secret_url)
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

  def sort_column
    Ticket.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
