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

  helper_method :current_user, :admin_user?, :can_manage_product?

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
end
