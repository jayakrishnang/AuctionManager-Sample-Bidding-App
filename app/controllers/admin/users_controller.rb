class Admin::UsersController < ApplicationController
  load_and_authorize_resource except: [:create]
  def index
    @users = User.where(role_id: Role.get_user_role_id).order(:id)
  end

  def new
    @user = User.new
    get_designation_and_role_data
  end

  def create
	  @user = User.new(user_params)
    @user.team_status = 'UNSOLD'
    if @user.save
      if (params[:user][:avatar].present? && params[:crop])
        render :crop
      else
        redirect_to admin_user_path(@user)
      end
  	else
  		get_designation_and_role_data
   		render 'new'
  	end
  end

  def show
    @user = User.where(id: params[:id]).first
    @teams = Team.get_team_stats
    @next_user = User.where('id > ? AND role_id = ?', params[:id], Role.get_user_role_id).limit(1).first
    if @user.team_status == 'UNSOLD'
      @bid_log = BidLog.new
    else
      @bid_log = BidLog.where(player_id: @user.id).order('amount DESC').limit(1).first
    end
    @new_bid_log = BidLog.new(player_id: @user.id, amount:@bid_log.amount)
  end
  
  def edit
    @user = User.find(params[:id])
    get_designation_and_role_data
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if (params[:user][:avatar].present? && params[:crop])
        render :crop
      else
        redirect_to admin_user_path(@user)
      end
    else
      get_designation_and_role_data
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def close_bid
    #to_be_written
  end

  def list_team_players
    @team_list = Team.joins(:users).select('teams.name, GROUP_CONCAT(CONCAT(users.first_name, users.last_name)) AS players').group('teams.id')
  end
  
  private
 	def user_params
    params.require(:user).permit(:first_name,
      :middle_name, :last_name, :email, :login_id, :password, :password_confirmation,
      :employee_id, :date_of_birth, :gender, :time_zone, :designation_id, :date_of_joining,
      :education, :comments, :role_id, :status, :deactivated_on, :reason, :previous_experience,
      :work_phone, :avatar, :remove_avatar, :crop_x, :crop_y, :crop_w, :crop_h, :team_status)
 	end

  def get_designation_and_role_data
    @designations=Designation.pluck(:designation_name, :id)
    @roles = Role.pluck(:name, :id)
  end
end
