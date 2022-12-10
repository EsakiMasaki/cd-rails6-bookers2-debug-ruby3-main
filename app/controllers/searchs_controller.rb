class SearchsController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search],params[:word])
      render "/searchs/search_index"
    else
      @books = Book.looks(params[:search],params[:word])
      render "/searchs/search_index"
    end
  end

end
