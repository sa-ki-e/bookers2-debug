class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    if @range = params[:range]
      @users = User.looks(params[:search], params[:word])
    # ↑下3行の意味
    # search = params[:search]
    # words = params[:word]
    # @users = User.looks(search, words)
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
