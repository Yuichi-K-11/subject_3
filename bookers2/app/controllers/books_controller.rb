class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] =  "Book was successfully created."
      redirect_to books_path(@book.id)

    else
      @books = Book.all
      render action: :index
    end

  end

  def edit
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])


  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] =  "Book was successfully updated."
      redirect_to books_path(@book.id)

    else
      render action: :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy

    if book.destroy
      flash[:notice] =  "Book was successfully destroyed."
      redirect_to books_path
    end
  end


  private

  def book_params
    params.require(:book).permit(:user_id, :title, :body)
  end
end
