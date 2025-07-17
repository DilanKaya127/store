class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Daha sonra tekrar deneyiniz." }

  def new
  end

  def create
    # User authentication logic
    user = User.find_by(email_address: params[:email_address])

    if user && user.authenticate(params[:password])
      merged_cart = merge_guest_cart_to_user
      # Modern Rails authentication sistemi kullan
      @session = start_new_session_for(user)
      Current.session = @session
      session[:session_id] = @session.id

      # Eğer birleştirme başarılıysa yeni sepeti aktif yap
      session[:cart_id] = merged_cart&.id if merged_cart.present?
      # flash[:notice] ||= "Sepetiniz başarıyla birleştirildi."

      # redirect_to after_authentication_url, notice: "Giriş başarılı!"
      redirect_to root_path
    else
      flash.now[:alert] = "Email veya şifre hatalı"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "Oturumunuz kapatıldı."
  end
end
