class CartsController < ApplicationController
  allow_unauthenticated_access only: [ :show, :index, :new, :create, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :checkout ]
  before_action :set_cart, only: [ :show, :edit, :update, :destroy ]

  def index
    @carts = Cart.all
  end

  def show
    @cart = Cart.find(params[:id])
    if @cart.user_id.present?
      unless current_user && @cart.user_id == current_user.id
        redirect_to root_path, alert: "Bu sepete erişim izniniz yok."
      end
    else
      unless @cart.session_id == session.id.to_s
        redirect_to root_path, alert: "Bu sepete erişim izniniz yok."
      end
    end
  end

  def new
    @cart = Cart.new
  end

  def create
    if current_user
      # Kullanıcının açık bir sepeti varsa ona yönlendir
      @cart = current_user.carts.find_by(status: "open")
      unless @cart
        @cart = current_user.carts.create(status: "open")
      end
    else
      # Misafir için session_id ile açık sepet bul veya oluştur
      @cart = Cart.find_by(session_id: session.id.to_s, status: "open")
      unless @cart
        @cart = Cart.create(session_id: session.id.to_s, status: "open")
      end
      session[:cart_id] = @cart.id
    end
    redirect_to @cart, notice: "Sepet hazır!"
  end

  def edit
  end

  def update
    if @cart.update(cart_params)
      redirect_to @cart, notice: "Sepet güncellendi."
    else
      render :edit
    end
  end

  def destroy
    @cart.destroy
    redirect_to carts_url, notice: "Sepet silindi."
  end

  def checkout
    unless current_user
      redirect_to new_session_path, alert: "Satın alma işlemi için giriş yapmalısınız."
      return
    end

    if @cart.user == current_user
      @cart.update(status: "completed", checked_out_at: Time.current)

      @cart.cart_items.each do |item|
        product = item.product
        product.units_in_stock -= item.quantity
        product.save
      end

      redirect_to @cart, notice: "Sepet başarıyla satın alındı."
    else
      redirect_to carts_path, alert: "Bu sepete erişiminiz yok."
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:user_id, :status, :checked_out_at, :total_price, :discount_applied)
  end
end
