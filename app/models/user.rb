class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	belongs_to :designation
	belongs_to :roles
	validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/}
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\z/}
	validates :login_id, presence: true, uniqueness: true
	validates :password, confirmation: true,  length: { in: 6..20 }, :on => :create
    validates :password_confirmation, presence: true, :on => :create
    validates :deactivated_on, absence: true, if: :is_active
 	validates :work_phone, format: {with: /\A(180\-)?[0-9]{3}(\-)?[0-9]{3}(\-)?[0-9]{4}\z/}
 	
 	before_save :set_default_role

 	def set_default_role
 		self.role_id ||= Role.find_by_name("user").id
 	end
end
