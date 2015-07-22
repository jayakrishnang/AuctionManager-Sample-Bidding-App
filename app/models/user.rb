class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :designation
  belongs_to :role
  mount_uploader :avatar, AvatarUploader
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/}
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\z/}
  validates :login_id, presence: true, uniqueness: true
  validates :password, confirmation: true,  length: { in: 6..20 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  #validates :deactivated_on, absence: true, if: :is_active
  validates :work_phone, format: {with: /\A(180\-)?[0-9]{3}(\-)?[0-9]{3}(\-)?[0-9]{4}\z/}
  before_save :set_default_role
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def set_default_role
    self.role_id ||= Role.find_by_name("user").id
  end
  def calculate_total_experience
    self.previous_experience + ((Date.today-self.date_of_joining)/365).round(2)
  end
end
