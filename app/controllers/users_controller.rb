class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  
  def new
    @user = User.new
  end

  def create
    existing_user = User.find_by(email_address: user_params[:email_address])
    if existing_user
      flash.now[:alert] = "Bu e-posta adresiyle zaten bir kullanıcı kayıtlı."
      @user = User.new # yeni kullanıcı objesi oluştur ki form yeniden render edilebilsin
      render :new, status: :unprocessable_entity
    else
      @user = User.new(user_params)
      if @user.save
        redirect_to root_path
      else
        flash.now[:alert] = "Kayıt başarısız: Lütfen eksik alanları düzeltin."
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password)
  end
end
