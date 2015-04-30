class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only:  :create
  skip_after_action  :verify_authorized,  only: [:create, :destroy]

  def create
    user = User.find_by_email(params[:user][:email])

    unless user && user.valid_password?(params[:user][:password])
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
end
