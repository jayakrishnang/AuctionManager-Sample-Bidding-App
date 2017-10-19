class Ball < ActiveRecord::Base
	belongs_to :over

	def get_over_summary
		if wicket_id.present?
			"#{runs_scored.zero? ? '' : "#{runs_scored}" + '+'}" + "#{extra_type.present? ? "#{extra}" + '+' + "#{extra_type.gsub(/[^A-Z]/, '')}" + '+': ''}" + 'W'
		elsif extra_type.present?
			"#{runs_scored.zero? ? '' : "#{runs_scored}" + '+'}" + "#{extra.present? ? "#{extra}" + '+' : ''}" + "#{extra_type.gsub(/[^A-Z]/, '')}"
		else
			"#{runs_scored}"
		end
	end
end
