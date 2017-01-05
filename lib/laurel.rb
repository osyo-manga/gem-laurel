require "laurel/version"
require "laurel/proxy"
require "laurel/operator"
require "laurel/core_refine"

module Laurel
	module_function
	def and a, b
		Laurel.proxy { |name, *args, &block|
			   a.__send__(name, *args, &block)    \
			&& b.__send__(name, *args, &block)
		}
	end

	module_function
	def or a, b
		Laurel.proxy { |name, *args, &block|
			   a.__send__(name, *args, &block)    \
			|| b.__send__(name, *args, &block)
		}
	end

	module_function
	def not a
		Laurel.proxy { |name, *args, &block|
			!a.__send__(name, *args, &block)
		}
	end
end
