def detector(b=(default=true; 1))
  puts "b=#{b} default=#{default.inspect}"
end

detector(15)
detector

# source: http://www.engineyard.com/blog/2009/3-ruby-quirks-you-have-to-love/
def foo(a, b=def foo(a); "F"; end)
  a
end

puts foo("W", 1) + foo("T") + foo("bar")
