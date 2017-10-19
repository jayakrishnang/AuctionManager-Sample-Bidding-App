class User < ApplicationRecord
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
    bid = BidLog.get_highest_bid(id)
    team = Team.where(owner_id: bid.user_id).first
    self.update_attributes(team_id: team.try(:id), team_status: 'SOLD', sold_points: bid.amount)
    team.purse_spent = team.purse_spent + bid.amount
    team.save
  end

  def update_team_status
    if team_status == 'UNSOLD'
      self.update_attributes(team_status: 'BIDDING')
    end
  end

  def get_full_name
    first_name + ' ' + middle_name + ' ' + last_name
  end

  def calculate_runs(inning_id)
    inning = Inning.where(id: inning_id).first
    record = Inning.select('SUM(balls.runs_scored) AS runs_sum,
                SUM(is_legitimate) AS balls_sum,
                SUM(result = "4 Runs") AS fours_sum,
                SUM(result = "6 Runs") AS sixes_sum')
            .joins('INNER JOIN overs ON overs.inning_id = innings.id
                INNER JOIN balls ON balls.over_id = overs.id')
            .where('balls.batsman_id = ? AND innings.id = ?', self.id, inning_id).first
    [record.runs_sum, record.balls_sum, record.fours_sum, record.sixes_sum]
  end

  def get_wicket_info(inning_id, balls_played)
    wicket = Wicket.where(inning_id: inning_id, batsman_id: self.id).first
    if wicket.present?
      bowler = User.where(id: wicket.bowler_id).first.get_full_name
      partner = User.where(id: wicket.wicket_partner_id).first.try(:get_full_name)
      case wicket.wicket_type
      when 'Bowled'
        "b #{bowler}"
      when 'Caught'
        "c #{partner} b #{bowler}"
      when 'LBW'
        "LBW #{bowler}"
      when 'Stumped'
        "st #{partner} b #{bowler}"
      when 'Run Out'
        "runout(#{partner})"
      when 'Hit Wicket'
        "hitwicket"
      when 'Hit Out'
        "hitout b #{bowler}"
      end
    else
      if balls_played.blank?
        "--"
      else
        "not out"
      end
    end
  end

  def crease_arrival_order(inning_id)
    arrival_time = Ball.joins(:over)
      .where('balls.batsman_id = ? AND overs.inning_id = ?', self.id, inning_id)
      .order('balls.created_at')
      .limit(1)
      .first.try(:created_at)
    arrival_time || Time.now
  end

  def get_bowling_details(inning_id)
    inning = Inning.where(id: inning_id).first
    overs = inning.overs.where(bowler_id: self.id)
    runs = Ball.select('SUM(runs_scored) AS runs').where(over_id: overs.map(&:id)).first
    ball_count = overs.map(&:legitimate_balls).flatten.count
    wickets = inning.wickets.where(bowler_id: self.id, wicket_type:['Bowled','Caught','LBW','Stumped','Hit Wicket','Hit Out']).count
    [(ball_count.to_f / 6).round(2), wickets, runs.runs]
  end


end
