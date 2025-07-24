class FavoritesController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]
  # before_action :authenticate_user! #devise ile kullanılır
  before_action :require_login
  before_action :set_product, only: [ :create, :destroy ]

  def create
    favorite = current_user.favorites.build(product: @product)

    respond_to do |format|
      if favorite.save
        format.turbo_stream do
          flash.now[:notice] = "Favorilere eklendi 💖"
          render turbo_stream: [
            turbo_stream.replace("product_#{@product.id}_favorite", partial: "products/partials/favorite_button", locals: { product: @product })
          ]
        end
        format.html { redirect_to products_path, notice: "Favorilere eklendi 🎉" }
      else
        format.html { redirect_to products_path, alert: "Zaten favoride 👀" }
      end
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(product: @product)

    respond_to do |format|
      if favorite
        favorite.destroy
        format.turbo_stream do
          flash.now[:notice] = "Favorilerden kaldırıldı 🗑️"
          render turbo_stream: [
            turbo_stream.replace("product_#{@product.id}_favorite", partial: "products/partials/favorite_button", locals: { product: @product })
          ]
        end
      end
      format.html { redirect_to favorites_path, notice: "Favorilerden kaldırıldı 🗑️" }
    end
  end

  private

  def require_login
    unless current_user
      redirect_to new_session_path, notice: "Favorileri görüntülemek için giriş yapmalısınız."
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
