class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show]
  before_action :set_product, only: %i[ show edit update destroy]
  def index
    @products = Product.all.limit(20)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Ürün başarıyla oluşturuldu."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Ürün başarıyla güncellendi."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Ürün başarıyla silindi."
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.expect(product: [ :ProductName, :QuantityPerUnit, :FeaturedImage, :UnitsInStock, :UnitPrice ])
    end
end