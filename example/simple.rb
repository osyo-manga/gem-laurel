require "laurel"

p Laurel.and(1, 2).to_s # => 1.to_s && 2.to_s

homu_or_mami = Laurel.or("homu", "mado")

p homu_or_mami == "homu"
# => true

p homu_or_mami == "mado"
# => true

p homu_or_mami == "mami"
# => false


# Using operators
# define Object#& Object#| Object#!
using Laurel::Refine

p "homu" | "mado" == "homu"
# => true

p "homu" | "mado" == "mado"
# => true

p "homu" | "mado" == "mami"
# => false

