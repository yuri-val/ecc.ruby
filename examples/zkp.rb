require "../lib/zkp.rb"

curve = Ecc::Curve.new -1, 188, 751
pointG = Ecc::Point.new 1, 375
pointQ = Ecc::Point.new 2, 373

alice = Ecc::ZKP.new curve, pointG, pointQ
bob   = Ecc::ZKP.new curve, pointG, pointQ

puts ""
puts "alice set_secret and calculate_Ya============================================"
alice.set_secret_ka 327, 715
alice.calculate_Ya
puts "k1, k2 = #{alice._k1}, #{alice._k2}"
puts "Ya(x,y) = (#{alice._Ya.x}, #{alice._Ya.y})"
