class ChatroomsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
