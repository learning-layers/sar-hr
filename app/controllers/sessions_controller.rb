class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only:  :create
  skip_after_action  :verify_authorized,  only: [:create, :destroy]

  def create
    email    = user_params.fetch(:email)
    password = user_params.fetch(:password)

    user = User.find_by_email(email)

    unless user && user.valid_password?(password)
      throw :warden, scope: :user
    end

    session = user.sessions.create!

    render json: session, status: :created
  end

  def destroy
    token = request.headers['HTTP_X_USER_TOKEN']
    session = Session.find_by_token!(token)

    authorize(session)

    session.destroy!

    head :no_content
  end

  def force_unique
    token = request.headers['HTTP_X_USER_TOKEN']
    session = Session.find_by_token!(token)

    authorize(session)

    sessions = session.user.sessions
    other_sessions = sessions - [session]

    for other_sessions in other_sessions
      other_session.destroy! if policy(other_session).destroy?
    end

    head :no_content
  end

protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
