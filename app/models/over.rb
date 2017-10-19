class Over < ActiveRecord::Base
	belongs_to :inning
	has_many :balls

	def update_status
		inning = self.inning
		if self.over_ended?
			self.update_attributes(status: 'COMPLETED')
			User.where(id: bowler_id).first.update_attributes(is_bowling: false)
			inning.overs_played = inning.overs_played.to_i + 1
		else
			self.update_attributes(status: 'ONGOING')
		end
		inning.save
	end

	def over_ended?
		balls.where(is_legitimate: true).count == 6
	end

	def legitimate_balls
		self.balls.where(is_legitimate: true)
	end
end
