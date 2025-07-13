class CartItemsController < ApplicationController
    allow_unauthenticated_access only: [ :create, :destroy ]
    before_action :set_cart_item, only: [ :edit, :update, :destroy ]

    def create
        logger.debug params.inspect # gelen parametreleri logla
        @cart_item = CartItem.find_or_initialize_by(cart_id: params[:cart_id], product_id: params[:product_id])
        @cart_item.quantity = params[:quantity].to_i
        @cart_item.unit_price = params[:unit_price]
        if @cart_item.save
            redirect_to cart_path(@cart_item.cart), notice: "Ürün sepete eklendi."
        else
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
