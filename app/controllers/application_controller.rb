class ApplicationController < ActionController::Base
  before_action :resume_session
  before_action :set_shared_categories

  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale
  # I18n.locale = :tr

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale = :tr
    I18n.with_locale(locale, &action)
  end

  helper_method :current_user, :admin_user?, :can_manage_product?, :current_cart

  private

  def set_shared_categories
    @categories = Category.all.order(:category_name)
  end

  def current_user
    @current_user ||= Current.session&.user

    # helper_method :current_user satırı sayesinde bu metot view'lerde kullanılabilir hale gelir.
  end

  # Admin kullanıcı kontrolü
  def admin_user?
    current_user&.admin?
  end

  # Supplier yetkilendirme kontrolü
  def require_admin
    redirect_to root_path, alert: "Bu işlem için yetkiniz yok." unless admin_user?
  end

  # Belirli bir ürünü yönetme yetkisi kontrolü
  def can_manage_product?(product)
    return false unless admin_user?
    return false unless current_user.supplier.present?

    # Eğer Product modelinde supplier_id yoksa, tüm admin'ler yönetebilir
    # Eğer supplier_id varsa, sadece ilgili supplier'ın admin'i yönetebilir
    if product.respond_to?(:supplier_id)
      product.supplier_id == current_user.supplier_id
    else
      true # supplier_id yoksa tüm admin'ler yönetebilir
    end
  end

  # Ürün sahipliği kontrolü
  def ensure_product_ownership
    unless can_manage_product?(@product)
      redirect_to products_path, alert: "Bu ürünü düzenleme yetkiniz yok."
    end
  end

  # user_id ya da session_id tabanlı sepeti bulur.
  # Bulduktan sonra session[:cart_id]'yi güvenli şekilde günceller.
  def current_cart
    if current_user
      cart = Cart.find_or_create_by(user_id: current_user.id, status: "open")
    else
      cart = Cart.find_or_create_by(session_id: session.id.to_s, status: "open")
    end

    session[:cart_id] = cart.id
    cart
  end

  def create_new_cart
    cart = Cart.new
    cart.user_id = current_user.id if current_user
    cart.session_id = session.id.to_s unless current_user
    cart.save
    cart
  end

  def merge_guest_cart_to_user
    return unless current_user.present?

    old_id = session[:old_session_id] || cookies.signed[:session_id]
    guest_cart = Cart.find_by(session_id: old_id, status: "open")
    return unless guest_cart

    user_cart = Cart.find_by(user_id: current_user.id, status: "open")

    if user_cart.nil?
      guest_cart.update(user_id: current_user.id, session_id: nil)
      flash[:notice] = "Sepetiniz başarıyla aktarıldı."
      return guest_cart
    end

    guest_cart.cart_items.each do |item|
      existing = user_cart.cart_items.find_by(product_id: item.product_id)
      if existing
        existing.quantity += item.quantity
        existing.total_price = existing.unit_price * existing.quantity
        existing.save
        item.destroy
      else
        item.update(cart_id: user_cart.id)
      end
    end

    guest_cart.destroy
    flash[:notice] = "Sepetiniz başarıyla birleştirildi. applicationcontroller"
    user_cart
  end
end
