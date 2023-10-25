class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @group = Group.new
  end

  def index
    @book = Book.new
    @user = current_user
    @groups = Group.all
  end

  def show
    @book = Book.new
    @user = current_user
    @group = Group.find(params[:id])
    @owner = User.find_by(id: @group.owner_id)
  end

  def edit
    @group = Group.find(params[:id])
  end
  
  def create
    group = Group.new(group_params)
    group.owner_id = current_user.id
    if group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end
  
  def update
    group = Group.find(params[:id])
    if group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  def new_mail
    @group = Group.find(params[:group_id])
  end
  
  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title,@mail_content,group_users).deliver
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name,:introduction,:group_image)
  end
  
end
