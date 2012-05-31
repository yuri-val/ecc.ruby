require "./lib/curve.rb"
require "./lib/el_gamel.rb"

curve = Ecc::Curve.new 14, 19, 3623
s_pt  = Ecc::Point.new 6, 730

alice     = Ecc::ElGamel.new curve, s_pt, 12
alice_pub = alice.computePublicKey()

bob     = Ecc::ElGamel.new curve, s_pt, 32
bob_pub = bob.computePublicKey()
message = Ecc::Point.new 2149, 196

crypted_text  = bob.encrypt message, alice_pub
plaintext     = alice.decrypt crypted_text
puts plaintext
puts message