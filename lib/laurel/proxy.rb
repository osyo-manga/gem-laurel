module Laurel
	class Proxy < BasicObject
		def initialize &block
			@block = block
		end
	
		def method_missing name, *args, &block
			@block.call name, *args, &block
		end
	end

	module_function
	def proxy ignores = [], &block
		Class.new(Laurel::Proxy) {
			def initialize &block
				super &block
			end
			ignores.each { |name|
				define_method(name){ |*args, &block|
					method_missing name, *args, &block
				}
			}
		}.new(&block)
	end
end
