class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def create
    if Entry.where(:user_id => current_user.id,:room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:message,:room_id,:user_id))
      redirect_to room_path(@message.room_id)
    else
      redirect_to user_path(current_user.id)
    end
  end
end
