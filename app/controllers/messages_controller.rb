class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    if @message.save
      redirect_to chatroom_path(@chatroom)
    else
      render 'chatrooms/show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :email_address)
  end
end
