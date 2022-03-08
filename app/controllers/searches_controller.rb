class SearchesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_q, only: [:index, :search]#★

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
  
  
  # def search
  #   @results = @q.result
  # end
  
  # private
  # def set_q
  #   @q = User.ransack(params[:q])
  # end
  
end
