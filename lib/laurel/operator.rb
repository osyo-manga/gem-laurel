require_relative "./proxy.rb"

module Laurel module Operator
	def & other
		Laurel.and(self, other)
	end

	def | other
		Laurel.or(self, other)
	end

	def !
		Laurel.not(self)
	end
end end
