class TeamOwner::UsersController < ApplicationController
	# load_and_authorize_resource except: [:create]
  def index
    @users = User.where(role_id: Role.get_user_role_id)
  end

  def show
    @user = User.find(params[:id])
    @total_experience = @user.calculate_total_experience
  end
end
