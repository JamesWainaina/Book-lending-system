class BooksController < ApplicationController
  # Ensure that users are logged in before allowing them to borrow or return books
  before_action :authenticate_user!, only: [:new, :create, :borrow, :confirm_borrow, :return]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  # Render borrow form for user to set return date
  def borrow
    @book = Book.find(params[:id])

    if @book.borrowed?
      redirect_to @book, alert: "This book is already borrowed."
    end
  end

  # Handle the submission of the borrowing form
  def confirm_borrow
    @book = Book.find(params[:id])

    if @book.borrowed?
      redirect_to @book, alert: "This book is already borrowed."
    else
      if @book.update(user: current_user, return_date: params[:return_date])
        redirect_to @book, notice: "You have successfully borrowed the book."
      else
        redirect_to @book, alert: "Failed to borrow the book. Please try again."
      end
    end
  end

  # Handle returning the book
  def return
    @book = Book.find(params[:id])

    if @book.user == current_user
      @book.update(user: nil, return_date: nil)
      redirect_to @book, notice: "You have successfully returned the book."
    else
      redirect_to @book, alert: "You cannot return a book that you have not borrowed."
    end
  end

  # New book form
  def new 
    @book = Book.new
  end

  # Create a new book
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path, notice: 'Book was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  
  # Permit the required and optional parameters
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :image, :return_date)
  end
end
