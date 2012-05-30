class Curve

  # Creates an elliptic curve of the form
  # 
  # y^2 = x^3 + ax + b
  # 
  # over the field fp
  # 
  # Although it is not explicitly checked, it should be
  # noted that operations work best over curves which are
  # non-singular, ergo the discriminant of the curve,
  # ∆ = 4a^3+27b^2, should be non-zero
  # 
  # Also note that for proper security, fp should be
  # a relatively large number and preferably prime,
  # as to avoid any problems with Lenstra factorization
  constructor: (a, b, fp) ->
    @a  = a
    @b  = b
    @fp = fp

  # Computes module for both positive and negative numbers
  @mod: (a, b) ->
    ((a % b) + b) % b

  # Computes the solutions to the equation
  # ax + by = gcd(a, b)
  # where a and b are given.
  @ext_gcd: (a, b) ->
    if b is 0
      [1, 0]
    else
      r = Curve.mod a, b
      q = (a - r) / b
      res = Curve.ext_gcd b, r
      t = res[1]
      [t, res[0] - (q * t)]

  # Computes the solution to equations of the form
  # a/b = x (mod p)
  # where a, b are given and p = Fp
  mod_inv: (a, b) ->
    res = Curve.ext_gcd b, @fp
    dis = res[1]
    x   = (a - (@fp * dis * a)) / b
  
    Curve.mod x, @fp

  # Subtracts two points on the curve
  # See mod_add below for a description of the algorithm
  mod_sub: (a, b) ->
    @mod_add a, new Ecc.Point(b.x, -b.y)

  # Adds two points on the curve
  mod_add: (a, b) ->
    return a if b.inf
    return b if a.inf

    x1 = a.x
    x2 = b.x
    y1 = a.y
    y2 = b.y

    return new Ecc.Point Infinity, Infinity if x1 is x2 and y1 is -y2

    if x1 is x2 and y1 is y2
      lambda = @mod_inv 3 * Math.pow(x1, 2) + @a, 2 * y1
    else
      lambda = @mod_inv y2 - y1, x2 - x1

    x3 = Curve.mod Math.pow(lambda, 2) - x1 - x2, @fp
    y3 = Curve.mod lambda * (x1 - x3) - y1,       @fp

    new Ecc.Point x3, y3

  # Adds a point on the curve, P, to itself n times
  # This has been implemented using the Double-and-Add algorithm.
  mod_mult: (p, n) ->
    q = p
    r = new Ecc.Point Infinity, Infinity

    while n > 0
      if n % 2 is 1
        r = @mod_add r, q

      q = @mod_add q, q
      n = Math.floor n / 2

    r

namespace "Ecc", (exports) ->
  exports.Curve = Curve