class A
  class << self
    define_method("foo\n@#5587!!!46. bar") do
      "foo" "bar"
    end
  end
end

puts A.methods - Object.methods
puts A.send("foo\n@#5587!!!46. bar")
