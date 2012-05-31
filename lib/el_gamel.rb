require "./lib/point"

module Ecc
  class ElGamel
    # Creates an elliptic elgamel instance to facilitate the encryption and decryption of data
    def initialize (curve, point, key)
      @curve  = curve
      @point  = point
      @key    = key
    end

    # Computes the public key based on the private key.
    def computePublicKey
      @curve.mod_mult @point, @key
    end

    # Encrypts a point using a public key.
    # The callback returns the ciphertext as it's first parameter.
    def encrypt (plaintext, pub_key)
      k = 0
      1024.times.each {
        k ^= Random.rand 255
      }
  
      c1 = @curve.mod_mult @point, k
      c2 = @curve.mod_add  plaintext, @curve.mod_mult(pub_key, k)
  
      Point.new c1, c2
    end

    # Decrypts a point using the given private key
    def decrypt (cipher_text)
      c1    = cipher_text.x
      c2    = cipher_text.y
      @curve.mod_sub c2, @curve.mod_mult(c1, @key)
    end
  end
end