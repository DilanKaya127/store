class ApplicationController < ActionController::Base
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

  def current_cart
    if session[:cart_id]
      Cart.find_by(id: session[:cart_id]) || create_new_cart
    else
      create_new_cart
    end
  end

  def create_new_cart
    cart = Cart.new
    cart.user_id = current_user.id if current_user
    cart.session_id = session.id.to_s unless current_user
    cart.save
    session[:cart_id] = cart.id
    cart
  end

  def merge_guest_cart_to_user
    guest_cart = Cart.find_by(session_id: session.id.to_s, status: "open")
    if guest_cart && current_user
      guest_cart.update(user_id: current_user.id, session_id: nil)
    end
  end
end
