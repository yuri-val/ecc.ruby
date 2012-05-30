#= require_tree ./lib
#= require elliptic/curve
#= require elliptic/point
#= require elliptic/el_gamel

curve = new Ecc.Curve 14, 19, 3623
s_pt  = new Ecc.Point 6, 730

alice     = new Ecc.ElGamel curve, s_pt, 12
alice_pub = alice.computePublicKey()

bob     = new Ecc.ElGamel curve, s_pt, 32
bob_pub = bob.computePublicKey()
message = new Ecc.Point 2149, 196

crypted_text  = bob.encrypt message, alice_pub
plaintext     = alice.decrypt crypted_text
console.log plaintext
console.log message