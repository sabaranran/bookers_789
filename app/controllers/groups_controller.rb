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
  
  private
  
  def group_params
    params.require(:group).permit(:name,:introduction,:group_image)
  end
  
end
