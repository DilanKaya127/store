class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index show]

  def index
    @products = Product.order(reorder_level: :desc).limit(10)
    @categories = Category.all
  end

  def show
  end
end
