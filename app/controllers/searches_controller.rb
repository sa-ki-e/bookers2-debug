class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
    
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    # ↑下3行の意味
    # search = params[:search]
    # words = params[:word]
    # @users = User.looks(search, words)
    else
      @books = Book.looks(params[:search], params[:word])
    end
    
  end
  
#   def search
# 		@model = params[:model]
# 		@content = params[:content]
# 		@method = params[:method]
# 		if @model == 'user'
# 			@records = User.search_for(@content, @method)
# 		else
# 			@records = Book.search_for(@content, @method)
# 		end
# 	end
  
end
