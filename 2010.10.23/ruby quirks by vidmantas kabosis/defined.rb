puts defined?(x)

begin
  puts x
rescue NameError
  puts "NameError"
end

# never executed?
if false
  x = 1
end

puts defined?(x)
puts x
