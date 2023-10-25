class TagsController < ApplicationController
  
  
  def search
    @tag = params[:tag]
    @books = Book.where("tag LIKE?", "%#{@tag}%")
    render "tags/search"
  end
  
  
  
end
