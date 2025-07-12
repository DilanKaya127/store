class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    # User authentication logic
    user = User.find_by(email_address: params[:email_address])

    if user && user.authenticate(params[:password])
      # Modern Rails authentication sistemi kullan
      start_new_session_for(user)

      redirect_to after_authentication_url
    else
      flash.now[:alert] = "Email veya şifre hatalı"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to root_path
  end
end
