require_relative "curve.rb"

module Ecc
  class ZKP
    attr_accessor :curve, :pointG, :pointQ,
                  :_n, :_Ya, :_Yb, :_x, :_y, :_y1, :_y2, :_y3,
                  :_k1, :_k2, :_kb
    attr_reader   :_r1, :_r2

    def initialize(curve, pointG, pointQ)
      @curve    = curve
      @pointG    = pointG
      @pointQ    = pointQ
    end

    def set_secret_ka(_k1 = nil, _k2 = nil)
      @_k1 = _k1.nil? ? rand(1..self._n - 1) : _k1
      @_k2 = _k2.nil? ? rand(1..self._n - 1) : _k2
    end

    def calculate_Ya
      k1G = @curve.mod_mult @pointG, @_k1
      k2Q = @curve.mod_mult @pointQ, @_k2
      @_Ya = @curve.mod_add k1G, k2Q
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
