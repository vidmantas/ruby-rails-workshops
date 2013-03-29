require 'benchmark'

def check_implicit
  yield
end

def check_explicit(&blck)
  blck.call
end

n = 1_000_000

Benchmark.bm do |x|
  x.report { n.times{ check_implicit{ Math.sqrt(9) } } }
  x.report { n.times{ check_explicit{ Math.sqrt(9) } } }
end