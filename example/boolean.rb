require "laurel"

using Laurel::Refine

Boolean = FalseClass | TrueClass

p Boolean === true
# => true

p Boolean === false
# => true

p Boolean === 0
# => false

p Boolean === nil
# => false
