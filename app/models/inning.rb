class Inning < ActiveRecord::Base
	belongs_to :match
	belongs_to :team
	has_many :overs
	has_many :wickets
end
