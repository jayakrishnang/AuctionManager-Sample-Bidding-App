class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :designation
  belongs_to :role
  belongs_to :team
  has_many :bid_logs
  mount_uploader :avatar, AvatarUploader
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/}
  validates :last_name, presence: true
  # validates :email, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\z/}
  #validates :deactivated_on, absence: true, if: :is_active
  # validates :work_phone, format: {with: /\A(180\-)?[0-9]{3}(\-)?[0-9]{3}(\-)?[0-9]{4}\z/}
  before_save :set_default_values, :revert_locked_data
  sync :all
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  
  scope :active_users, -> {where("status='Active'")}
  scope :locked_users, -> {where("status='Locked'")}
  scope :created_before, ->(time) { where("created_at < ?", time).select(:first_name)}
  def revert_locked_data
    if self.status == "Active"
      self.deactivated_on = nil
      self.reason = nil
    end
  end
  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def set_default_values
    self.role_id ||= Role.find_by_name("user").try(:id)
    self.status ||= "Active"
  end
  def calculate_total_experience
    # self.previous_experience + ((Date.today-self.date_of_joining)/365).round(2)
  end

  def get_team_name
    team.try(:name)
  end

  def sell_player
    bid = BidLog.where(player_id: id).group('amount DESC').first
    bidder = bid.user
    self.update_attributes(team_id: bidder.team_id, team_status: 'SOLD', sold_points: bid.amount)
  end

  def update_team_status
    if team_status == 'UNSOLD'
      self.update_attributes(team_status: 'BIDDING')
    end
  end
end
