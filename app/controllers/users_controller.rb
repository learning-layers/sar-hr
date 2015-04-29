class UsersController < ApplicationController
  def index
    render json: authorize(User.all), each_serializer: UserStubSerializer
  end

  def show
    render json: authorize(User.find(params[:id]))
  end

  def create
    render json: authorize(User.create!(user_params)), status: :created
  end

  def update
    authorize(user = User.find(params[:id]))
    user.update!(user_params)
    render json: user
  end

  def destroy
    authorize(User.find(params[:id])).delete
    head :no_content
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name,
                                 :status)
  end
end
