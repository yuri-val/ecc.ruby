require "./lib/curve"

module Ecc
  class DiffieHellman
    # Creates a diffieHellman instance to compute a shared key using a public elliptic curve and a point on that curve.
    def initialize (curve, point, pri_key)
      @curve    = curve
      @point    = point
      @pri_key  = pri_key
    end
  
    # Computes the public key for the given private key
    def computePublicKey
      @curve.mod_mult @point, @pri_key
    end
  
    # Computes the shared secret given a public key
    def computeSharedSecret (pub_key)
      @curve.mod_mult pub_key, @pri_key
    end
  end
end