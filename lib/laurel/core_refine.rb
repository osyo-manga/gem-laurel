require_relative "./operator.rb"

module Laurel module Refine
	def self.const_missing name
		klass = ::ObjectSpace.each_object(::Class).find { |klass| klass.name == name.to_s }
		usable klass
	end

	def self.usable klass
		::Module.new do
			refine klass do
				include ::Laurel::Operator
			end
		end
	end

	include Refine::Object
	include usable Laurel::Proxy
end end
