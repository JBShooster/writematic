class BooksController < ApplicationController
  def index
    @user = session[:user_id]
    @category = params[:category]
    if @category
      @books = Book.where(category: @category)
    else
      @books = Book.order('created_at DESC')
    end
    @categories = Category.all
    respond_to do |format|
      format.html
      format.json {render :json => @books}
    end
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = session[:user_id]
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def show
    @book = Book.find params[:id]
  end

  def destroy
    book = Book.find params[:id]
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title,
      :author,
      :cover,
      :content,
      :description,
      :pages,
      :hits,
      :category,
      :publish_date,
      :user_id)
    end

  def user_params
    params.require(:user).permit(:id, :username, :name, :password, :email, :password_digest)
  end

end
