class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show]
  before_action :set_product, only: %i[ show edit update destroy]
  before_action :set_categories, only: [ :index, :new, :edit ]
  before_action :require_admin, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :ensure_product_ownership, only: [ :edit, :update, :destroy ]

  def index
    @products = Product.all

    @products = apply_filters(Product.all)

    # AJAX istekleri için
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show
  end

  def new
    @product = Product.new
    # @categories zaten before_action'da yükleniyor
    # Product modelindeki supplier_id'i varsayılan olarak atamak için
    @product.supplier_id = current_user.supplier_id if current_user.supplier.present?
  end

  def create
    @product = Product.new(product_params)

    # Eğer Product modelinde supplier_id varsa, otomatik olarak ata
    if @product.respond_to?(:supplier_id) && current_user.supplier.present?
      @product.supplier_id = current_user.supplier_id
    end

    if @product.save
      redirect_to @product, notice: "Ürün başarıyla oluşturuldu."
    else
      set_categories # Hata durumunda kategorileri tekrar yükle
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @categories zaten before_action'da yükleniyor
    # ensure_product_ownership zaten before_action'da kontrol ediliyor
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Ürün başarıyla güncellendi."
    else
      set_categories # Hata durumunda kategorileri tekrar yükle
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Ürün başarıyla silindi."
  end

  def my_products
    if current_user&.supplier.present?
      @products = Product.where(supplier_id: current_user.supplier_id)
    else
      redirect_to products_path, alert: "Bu sayfayı görüntüleme yetkiniz yok."
      return
    end

    @products = apply_filters(Product.where(supplier_id: current_user.supplier_id))
    render :my_products
  end

  def apply_filters(products)
    @current_category = nil

    # Kategori filtreleme
    if params[:category_id].present?
      @current_category = Category.find_by(id: params[:category_id])
      products = products.where(category_id: params[:category_id]) if @current_category
    end

    # Arama filtreleme
    if params[:search].present?
      products = products.where("product_name LIKE ?", "%#{params[:search]}%")
    end

    # Fiyat aralığı filtreleme
    if params[:price_range].present?
      case params[:price_range]
      when "0-10"
        products = products.where(unit_price: 0..10)
      when "10-50"
        products = products.where(unit_price: 10..50)
      when "50-100"
        products = products.where(unit_price: 50..100)
      when "100+"
        products = products.where("unit_price > ?", 100)
      end
    end

    # Stok durumu filtreleme
    if params[:stock_status].present?
      case params[:stock_status]
      when "in_stock"
        products = products.where("units_in_stock > 0")
      when "out_of_stock"
        products = products.where("units_in_stock = 0 OR units_in_stock IS NULL")
      end
    end

    # Sıralama
    if params[:sort_by].present?
      case params[:sort_by]
      when "price_asc"
        products = products.order(:unit_price)
      when "price_desc"
        products = products.order(unit_price: :desc)
      when "name_asc"
        products = products.order(:product_name)
      else
        products = products.order(:id) # Varsayılan sıralama. DEĞİŞTİREBİLİRİM
      end
    end

    # Sayfa başına öğe sayısı
    per_page = params[:per_page]&.to_i || 20
    per_page = 20 unless [ 20, 50, 100 ].include?(per_page)
    products = products.page(params[:page]).per(per_page)

    products
end


  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.expect(product: [ :product_name, :quantity_per_unit, :featured_image, :units_in_stock, :unit_price, :category_id, :units_in_order, :reorder_level, :discontinued ])
    end

    def set_categories
      @categories = Category.all.order(:category_name)
    end
end
