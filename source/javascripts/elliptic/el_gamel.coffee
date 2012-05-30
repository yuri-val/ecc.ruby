#= require elliptic/point

class ElGamel
  # Creates an elliptic elgamel instance to facilitate the encryption and decryption of data
  constructor: (curve, point, key) ->
    @curve  = curve
    @point  = point
    @key    = key

  # Computes the public key based on the private key.
  computePublicKey: ->
    @curve.mod_mult @point, @key

  # Encrypts a point using a public key.
  # The callback returns the ciphertext as it's first parameter.
  encrypt: (plaintext, pub_key) ->
    rand = new Uint8Array 1024
    crypto.getRandomValues rand
    
    k = 0
    for i in [0...1024]
      k ^= rand[i]

    c1 = @curve.mod_mult @point, k
    c2 = @curve.mod_add  plaintext, @curve.mod_mult(pub_key, k)

    new Ecc.Point(c1, c2)

  # Decrypts a point using the given private key
  decrypt: (cipher_text) ->
    c1    = cipher_text.x
    c2    = cipher_text.y
    @curve.mod_sub c2, @curve.mod_mult(c1, @key)

namespace "Ecc", (exports) ->
  exports.ElGamel = ElGamel