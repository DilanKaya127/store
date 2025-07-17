class CartItemsController < ApplicationController
    allow_unauthenticated_access only: [ :create, :destroy ]
    before_action :set_cart_item, only: [ :edit, :update, :destroy ]

    def create
        logger.debug "Gelen Params: #{params.permit!.inspect}"
        @cart = current_cart || Cart.find(params[:cart_id])

        # Sepet sahipliği kontrolü
        if current_user
            # 1. User'a ait açık cart var mı?
            cart = Cart.find_by(user_id: current_user.id, status: "open")
            # 2. Yoksa, eski session_id ile cart var mı? (misafirden kalan)
            unless cart
              cart = Cart.find_by(session_id: session[:old_session_id] || session.id.to_s, status: "open")
              if cart
                cart.update(user_id: current_user.id, session_id: nil)
              end
            end
            # 3. Hala yoksa yeni oluştur
            unless cart
              cart = Cart.create(user_id: current_user.id, status: "open")
            end
            cart
        else
            # Misafir için session_id ile cart
            cart = Cart.find_or_create_by(session_id: session.id.to_s, status: "open")
            session[:cart_id] = cart.id
            cart
        end

        product = Product.find(params[:product_id])
        quantity = params[:quantity].to_i

        # Stok ve miktar kontrolü
        if quantity < 1 || quantity > product.units_in_stock
            redirect_to product_path(product), alert: "Geçersiz miktar." and return
        end

        @cart_item = CartItem.find_or_initialize_by(cart_id: @cart.id, product_id: product.id)
        @cart_item.quantity = quantity
        @cart_item.unit_price = product.unit_price
        @cart_item.total_price = product.unit_price * quantity
        logger.debug "CartItem: #{@cart_item.inspect}"

        if @cart_item.save
            redirect_to cart_path(@cart), notice: "Ürün sepete eklendi."
        else
            logger.debug "CartItem errors: #{@cart_item.errors.full_messages}"
            redirect_to products_path, alert: "Sepete ekleme başarısız."
        end
    end

    def update
        @cart_item = CartItem.find(params[:id])

        if @cart_item.cart.user == current_user || @cart_item.cart.session_id == session_id.to_s
            new_quantity = params[:cart_item][:quantity].to_i

            if new_quantity <= 0
                @cart_item.destroy
                redirect_to cart_path(@cart_item.cart), notice: "Ürün sepetten kaldırıldı."
            else
                @cart_item.quantity = new_quantity
                @cart_item.total_price = @cart_item.unit_price * new_quantity

                if @cart_item.save
                    redirect_to cart_path(@cart_item.cart), notice: "Sepet güncellendi."
                else
                    redirect_to cart_path(@cart_item.cart), notice: "Sepet güncellenemedi."
                end
            end
        else
            redirect_to carts_path, alert: "Bu sepete erişiminiz yok."
        end
    end

    def destroy
        @cart_item.destroy
        redirect_to cart_path(@cart_item.cart), notice: "Ürün sepetten kaldırıldı."
    end

    private

    def set_cart_item
        @cart_item = CartItem.find(params[:id])
    end

    def cart_item_params
        params.require(:cart_item).permit(:cart_id, :product_id, :quantity, :unit_price)
    end
end
