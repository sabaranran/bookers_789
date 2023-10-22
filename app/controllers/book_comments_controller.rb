class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(comment_params)
    @comment.book_id = book.id
    @comment.save
    @book = Book.find(params[:book_id])
  end

  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    @book = Book.find(params[:book_id])
  end

  private
  def comment_params
    params.require(:book_comment).permit(:body)
  end
  
  
end
