require 'nokogiri'
require 'pp'

load "channels.rb"

data = []
cnt = Hash.new(0)

Dir["pages/*"].each do |file|
  cnt[:files] += 1
  print '.' if cnt[:files] % 10 == 0
  doc = File.open(file, 'r:utf-8'){|f| Nokogiri::HTML(f, nil , 'utf-8') }
  
  title = doc.css("td.BlackText_Bold_16px").first.text.gsub("\u{A0}","")
  # p title
  row = $channels.detect {|it| it[2] == title } or raise "no channel #{title}"
  cid = row[1]
  
  # p title, cid
  doc.css("#MainContentArea td.LightGreyBg tr.WhteBg").each do |tr|
    tr.css("td.padding6").each_with_index do |day,idx|
      day.xpath("//td[@id]").each do |td|
        cnt[:prog] += 1
        time = td.css("div.time").first.text.strip
        prog = td.css("div.caption a").first.text.strip
      
        data << [cid, idx, time, prog]
      end
    end
  end
end

pp cnt

File.open("data.rb","w:utf-8"){|f| f.print data.pretty_inspect }
