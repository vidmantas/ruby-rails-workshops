
$sta = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

def decode(str)
  g = 0
  str.gsub!(%r{[^A-Za-z0-9\+/=]}, '')
  res = ""
  
  while g < str.length
    m = $sta.index(str[g]); g += 1
    k = $sta.index(str[g]); g += 1
    i = $sta.index(str[g]); g += 1
    h = $sta.index(str[g]); g += 1
    
    n = (m << 2) | (k >> 4)
    l = ((k & 15) << 4) | (i >> 2)
    j = ((i &  3) << 6) | h
    
    res += n.chr
    if i != 64
      res += l.chr
    end
    if h != 64
      res += j.chr
    end
  end
  
  res
end

%w(
anVzc2kuaW5rYWxhQGxhdmFqdXNzaS5maQ==
anVoYS5yaW5uZUByYWtlbm5lcGFsdmVsdS5jb20=
b2xhdmkucmFzYW5lbkBvci1ncm91cC5maQ==
am9ybWEuaHV1aHRhbmVuQGthYWtvbmxhdmFwYWx2ZWx1LmNvbQ==
).each do |it|
  puts decode(it)
end