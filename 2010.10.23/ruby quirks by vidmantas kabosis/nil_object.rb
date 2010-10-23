puts defined?(nil)

begin
  x += 1
rescue 
  puts "rescued"
end

def nil.+(other)
  other
end

y += 1
puts y
