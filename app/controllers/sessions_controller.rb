class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only:  :create
  skip_after_action  :verify_authorized,  only: [:create, :destroy]

  def create
    email = user_params[:email]
    password = user_params[:password]

    user = User.find_by_email(email)

    unless user && user.valid_password?(password)
      throw :warden, scope: :user
    end

    render json: user.sessions.create!, status: :created
  end

  def destroy
    token = request.headers['HTTP_X_USER_TOKEN']
    session = Session.find_by_token!(token)

    authorize(session).destroy!

    head :no_content
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
