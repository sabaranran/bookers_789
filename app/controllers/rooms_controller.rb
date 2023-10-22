class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id,:room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_to user_path(current_user.id)
    end
  end
  
  def create
    @room = Room.create(:user_id => current_user.id)
    @e1 = Entry.create(:room_id => @room.id,:user_id => current_user.id)
    @e2 = Entry.create(:room_id => @room.id,:user_id => params[:entry][:user_id])
    redirect_to room_path(@room)
  end
  
end
