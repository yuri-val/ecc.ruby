require "./lib/log.rb"

# not exist
puts Ecc::Log.new(3, 7, 30).brute().inspect

# # single answer - 9
puts Ecc::Log.new(3, 14, 17).brute().inspect

# multiple answers - [2, 4, 6, 8]
puts Ecc::Log.new(2155, 1545, 20).brute().inspect

# 6 is generator
log = Ecc::Log.new(3, 4, 13)
puts log.is_generator(6).to_s
puts log.is_generator(10).to_s

# random generator
puts log.random_generator

# baby-step giant-step algorithm. answer - 982
puts Ecc::Log.new(2341, 1, 983).baby_step_giant_step

# generate example in Zp
log = Ecc::Log.new(nil, nil, 104729)
log.a = log.random_generator
log.b = rand(log.n - 1).floor
puts "a = " + log.a.to_s + ", b = " + log.b.to_s + ", n = " + log.n.to_s
puts "solution = " + log.baby_step_giant_step.to_s