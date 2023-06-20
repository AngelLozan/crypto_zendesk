require 'pry-byebug'

class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    @chatroom = Chatroom.find_by(secret_url: params[:secret_url])
    # binding.pry
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    if user_signed_in?
      @message.email_address = @chatroom.ticket.user.email
    else
      @message.email_address = @chatroom.ticket.client_email
    end
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: {message: @message})
      )
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render 'chatrooms/show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :email_address)
  end
end
