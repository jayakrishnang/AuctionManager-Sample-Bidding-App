class Admin::UsersController < ApplicationController
  load_and_authorize_resource except: [:create]
  def index
  	@users = User.all
    
  end

  def new
  	@user = User.new
    get_designation_and_role_data
  end

  def create
	  @user = User.new(user_params)
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
  	@user = User.find(params[:id])
    @total_experience = @user.calculate_total_experience
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
  
  private
 	def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :login_id, :password, :password_confirmation, :employee_id, :date_of_birth, :gender, :time_zone, :designation_id, :date_of_joining, :education, :comments, :role_id, :status, :deactivated_on, :reason, :previous_experience, :work_phone, :avatar, :remove_avatar, :crop_x, :crop_y, :crop_w, :crop_h )
 	end
  def get_designation_and_role_data
    @designations=Designation.designation_list
    @roles = Role.role_list
  end
end
