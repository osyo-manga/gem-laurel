require "laurel"

# define Object#& Object#| Object#!
using Laurel::Refine

def func n
	case n
	when Integer & 0.method(:>).to_proc
		"minus"
	when Integer & 0.method(:==).to_proc
		"zero"
	when Integer & 0.method(:<).to_proc
		"plus"
	else
		"other"
	end
end

p func -1
# => "minus"

p func 0
# => "zero"

p func 1
# => "plus"

p func "homu"
# => "other"

p func []
# => "other"
