class UsersController < ApplicationController
   before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today = @books.created_today.count
    @yesterday = @books.created_yesterday.count
    @this_week = @books.created_this_week.count
    @last_week = @books.created_last_week.count
    
    if @yesterday == 0
      @ty = "前日の投稿はなし"
    else
      @ty = (@today/@yesterday*100).round
    end
    
    if @last_week == 0
      @tl = "前週の投稿はなし"
    else
      @tl = (@this_week/@last_week*100).round
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
