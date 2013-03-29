a = lambda{ puts "meh" }
a[]

b = lambda { |n1, n2| n1 + n2 }
puts b.call(2, 1)

def c
  myproc = proc { 1+1; break }
  [1,2,3].each do |i|
    puts i 
    myproc.call
  end
  2 + 2
end

puts c

puts

d = ->(n) { puts n }
d.call("meh")