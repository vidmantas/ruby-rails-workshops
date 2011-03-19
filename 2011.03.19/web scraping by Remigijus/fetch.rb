require 'nokogiri'
require 'pp'

file = 'samples/channels.html'
site = 'http://www.tv24.lt'

doc = File.open(file, 'r:utf-8'){|f| Nokogiri::HTML(f, nil , 'utf-8') }

data = []
cnt = Hash.new(0)  
  
group = nil  
doc.xpath('//a').each do |a|
  case it = a[:href]
  when %r{^/group/}
    cnt[:group] += 1
    group = a.text.strip
  when %r{^/channel/(\d+)/}
    cnt[:channel] += 1
    data << [site+it, $1, a.text.strip, group]
  end
end

p cnt

File.open("channels.rb","w:utf-8"){|f| f.print data.pretty_inspect }
File.open("channels.txt","w")do |f|
  data.each {|it|  f.puts it[0] }
end 