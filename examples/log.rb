require "./lib/log.rb"

puts Ecc::Log.new(3, 14, 17).brute().inspect
puts Ecc::Log.new(2155, 1545, 20).brute().inspect