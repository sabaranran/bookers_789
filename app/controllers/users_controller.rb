class UsersController < ApplicationController
   before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    @current_entry = Entry.where(user_id: current_user.id)
    @userentry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @current_entry.each do |c|
        @userentry.each do |u|
          if c.room_id == u.room_id
            @isroom = true
            @roomid = c.room_id
          end
        end
      end
    end
    if @isroom
    else
      @room = Room.new
      @entry = Entry.new
    end

  end

  def index
    @users = User.all
    @book = Book.new
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private
    def user_params
       params.require(:user).permit(:name, :introduction)
    end

end
