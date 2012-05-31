require "./lib/diffie_hellman.rb"

curve = Ecc::Curve.new 324, 1287, 3851
point = Ecc::Point.new 920, 303

alice = Ecc::DiffieHellman.new curve, point, 1194
bob   = Ecc::DiffieHellman.new curve, point, 1759

alice_pub = alice.computePublicKey()
bob_pub   = bob.computePublicKey()

res1 = alice.computeSharedSecret bob_pub
res2 = bob.computeSharedSecret alice_pub

puts res1
puts res2