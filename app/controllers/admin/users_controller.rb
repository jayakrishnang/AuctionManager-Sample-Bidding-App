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
    	redirect_to admin_user_path(@user)
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
      redirect_to admin_user_path(@user)
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
    params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :login_id, :password, :password_confirmation, :employee_id, :date_of_birth, :gender, :time_zone, :designation_id, :date_of_joining, :education, :comments, :role_id, :is_active, :deactivated_on, :reason, :previous_experience, :work_phone)
 	end
  def get_designation_and_role_data
    @designations=Designation.pluck(:designation_name, :id)
    @roles = Role.pluck(:name, :id)
  end
end
