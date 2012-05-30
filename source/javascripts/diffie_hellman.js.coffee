#= require_tree ./lib
#= require elliptic/curve
#= require elliptic/point
#= require elliptic/diffie_hellman

curve = new Ecc.Curve 324, 1287, 3851
point = new Ecc.Point 920, 303

alice = new Ecc.DiffieHellman curve, point, 1194
bob   = new Ecc.DiffieHellman curve, point, 1759

alice_pub = alice.computePublicKey()
bob_pub   = bob.computePublicKey()

res1 = alice.computeSharedSecret bob_pub
res2 = bob.computeSharedSecret alice_pub

console.log res1
console.log res2