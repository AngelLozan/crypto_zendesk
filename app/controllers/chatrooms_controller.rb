class ChatroomsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    @chatroom = Chatroom.find_by(secret_url: params[:secret_url])
    @message = Message.new
    @current_user = current_user
  end

end
