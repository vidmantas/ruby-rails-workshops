# implicit
def fatness
  print "yo mama"
  yield
  puts " that light bends around her"
end

fatness { print "so fat" }
puts 

# explicit
def fatness2(&bl)
  puts bl.class 
  bl.call
end

fatness2 { puts "Said!" }


# implicit within implicit
x = lambda do 
  puts "heallow"
  yield
end

x.call{ puts "world" }