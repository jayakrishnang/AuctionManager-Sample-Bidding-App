module Admin::InningsHelper

	def get_result_master_list
		['1 Run',
			'2 Runs',
			'3 Runs',
			'4 Runs',
			'5 Runs',
			'6 Runs',
			'Wicket',
			'Extra',
			'Dead']
	end

	def get_wicket_master_list
		[nil,
			'Bowled',
			'Caught',
			'LBW',
			'Stumped',
			'Run Out',
			'Hit Wicket',
			'Hit Out']
	end

	def get_extra_master_list
		[nil,
			'Wide Ball',
			'No Ball',
			'Bye',
			'Leg Bye']
	end
end
