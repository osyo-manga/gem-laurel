module Laurel
	class Proxy < BasicObject
		def initialize &block
			@block = block
		end
	
		def method_missing name, *args, &block
			@block.call name, *args, &block
		end

		[:==, :!=, :!].each { |name|
			define_method(name){ |*args, &block|
				method_missing name, *args, &block
			}
		}
	end

	module_function
	def proxy &block
		Laurel::Proxy.new &block
	end
end
