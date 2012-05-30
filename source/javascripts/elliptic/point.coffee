class Point
  # Creates a point x, y, where x and y can be Infinity.
  constructor: (x, y) ->
    if x is Infinity and y is Infinity
      @inf = true
    else
      @inf = false

    @x = x
    @y = y

namespace "Ecc", (exports) ->
  exports.Point = Point