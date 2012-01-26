<<LINE
The quick brown fox jumps over the lazy dog
LINE

def meth(a, b)
  puts a
  puts b
end

meth(<<ONE, <<TWO)
The quick brown fox jumps over the lazy dog 1
ONE
The quick brown fox jumps over the lazy dog 2
TWO
