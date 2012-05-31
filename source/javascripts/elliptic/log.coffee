#= require vendor/schemeNumber

class Log
  @primes = {}
  
  constructor: (a, b, n) ->
    @a      = a
    @b      = b
    @n      = n
    @fn     = Log.eiler n
    
  brute: ->
    res = []
    for i in [1...@fn]
      if (Math.pow(@a, i) - @b) % @n is 0
        res.push i
    res

  @eiler: (num) ->
    factors = Log.factor num
    res = 1
    for factor in factors
      res *= 1 - 1 / factor
    num * res

  @factor: (num) ->
    factors = []
    length = Math.floor Math.sqrt(num)
    return [] if length < 2
    for i in [2..length]
      if num % i is 0
        if Log.is_prime(i)
          factors.push i
        j = num / i
        if j isnt i
          if Log.is_prime(j)
            factors.push j
    factors.sort (a, b) ->
      a - b

  @is_prime: (num) ->
    if @primes[num]?
      @primes[num]
    else
      @primes[num] = Log.factor(num).length is 0

namespace "Ecc", (exports) ->
  exports.Log = Log