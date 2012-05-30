class DiffieHellman
  # Creates a diffieHellman instance to compute a shared key using a public elliptic curve and a point on that curve.
  constructor: (curve, point, pri_key) ->
    @curve    = curve
    @point    = point
    @pri_key  = pri_key

  # Computes the public key for the given private key
  computePublicKey: ->
    @curve.mod_mult @point, @pri_key

  # Computes the shared secret given a public key
  computeSharedSecret: (pub_key) ->
    @curve.mod_mult pub_key, @pri_key

namespace "Ecc", (exports) ->
  exports.DiffieHellman = DiffieHellman