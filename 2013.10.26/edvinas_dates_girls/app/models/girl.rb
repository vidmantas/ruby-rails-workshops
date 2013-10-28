class Girl < ActiveRecord::Base
	def is_worth_another_date?
		is_worth_another_date2?
	end

	private

	def is_worth_another_date2?
		stars >= 5
	end

end
