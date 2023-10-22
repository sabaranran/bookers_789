class FavoritesController < ApplicationController
  
  def create
    if !Favorite.exists?(book_id: params[:book_id], user_id: current_user.id)
      favorite = current_user.favorites.new(book_id: params[:book_id])
      favorite.save
      @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    else
      @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    end
  end

  def destroy
    if Favorite.exists?(book_id: params[:book_id], user_id: current_user.id)
      @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
      @favorite.destroy
    else
      @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    end
  end
  
  
  
end
