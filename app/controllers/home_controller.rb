class HomeController < ApplicationController

  # ensure only authenticated users can access the homepage
  # before_action :authenticate_user!
  
  def index
    @books = Book.all
    # @users = User.all
  end
end
