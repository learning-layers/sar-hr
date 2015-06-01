class UsersController < ApplicationController
  def index
    render json: policy_scope(User)
  end

  def show
    user = User.find(params[:id])

    authorize(user)

    render json: user
  end

  def create
    user = User.create!(user_params)

    authorize(user)

    render json: user, status: :created
  end

  def update
    user = User.find(params[:id])

    authorize(user)

    user.update!(user_params)

    render json: user
  end

  def destroy
    user = User.find(params[:id])

    authorize(user)

    user.destroy!

    head :no_content
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name,
                                 :title, :status, :peer_id, :skill_ids => [])
  end
end
