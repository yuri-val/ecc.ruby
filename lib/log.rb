module Ecc
  class Log
    @@primes = {}
    
    def initialize (a, b, n)
      @a      = a
      @b      = b
      @n      = n
      @fn     = Log.eiler n
    end
      
    def brute
      res = []
      for i in (1...@fn)
        if ((@a ** i) - @b) % @n == 0
          res.push i
        end
      end
      res
    end
  
    def self.eiler (num)
      factors = Log.factor num
      res = 1
      for factor in factors
        res *= 1 - 1.0 / factor
      end
      num * res
    end
  
    def self.factor (num)
      factors = []
      length = Math.sqrt(num).floor
      if length < 2
        return []
      end

      for i in (2..length)
        if num % i == 0
          if Log.is_prime(i)
            factors.push i
          end
          j = num / i
          if j != i
            if Log.is_prime(j)
              factors.push j
            end
          end
        end
      end
      
      factors.sort{ |a, b|
        a - b
      }
    end
  
    def self.is_prime (num)
      if @@primes.has_key? num
        @@primes[num]
      else
        @@primes[num] = Log.factor(num).length == 0
      end
    end
  end
end