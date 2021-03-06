class BooksController < ApplicationController
   before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
     @user = @book.user
     @books = Book.new#renderへの値
     @book_comment = BookComment.new#コメントを投稿するためのインスタンス変数
  end

  def index
    @books = Book.all
    @book = Book.new#renderへの値
    
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
    #@books = Book.all.order(created_at: :desc)
   
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :content, :category)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
    redirect_to books_path
    end
  end

end
