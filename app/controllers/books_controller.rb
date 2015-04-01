class BooksController < ApplicationController
  def index
    # @user = User.find user_params[:username]
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
    @user = User.find_by_id(params[:user_id])
  end

  def create
    @book = Book.new(book_params)
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
      :publish_date)
    end

  def user_params
    params.require(:user).permit(:id, :username, :name, :password, :email, :password_digest)
  end

end
