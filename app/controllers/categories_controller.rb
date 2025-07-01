class CategoriesController < ApplicationController
  allow_unauthenticated_access only: %i[ index show]
  before_action :set_categories  # Tüm action'lar için kategorileri yükle
  before_action :set_category, only: %i[ show edit update destroy]

  def index
    @categories = Category.all
  end

  def show
    # Kategoriye ait ürünleri göstermek için
    @products = Product.where(category_id: @category.Id)
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def set_categories
      @categories = Category.all.order(:category_name)
    end

    def category_params
      params.expect(category: [ :category_name ])
    end
end
