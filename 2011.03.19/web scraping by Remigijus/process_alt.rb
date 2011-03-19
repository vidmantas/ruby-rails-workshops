require 'nokogiri'
require 'pp'

load 'channels.rb'

cnt = Hash.new(0)

data = []
Dir["pages/*"].each do |file|
  cnt[:files] += 1
  print '.' if cnt[:files] % 10 == 0
  
  doc = File.open(file,'r:utf-8') {|f| Nokogiri::HTML(f, nil, 'utf-8') }
  
  title = doc.css("td.BlackText_Bold_16px").first.text
    .gsub("\u{A0}"," ").strip
  channel = $channels.detect {|it| it[0] == title} \
    or raise "No channel #{title.inspect}, #{file}"
  cidx = channel[1]
  # puts title
  
  doc.css("#MainContentArea td.LightGreyBg tr.WhteBg").each_with_index do |tr,idx|
    next if idx == 0
    
    days = tr.css("td.padding6.BlackText_Bold_13px")
      .map {|td| td.text.strip }
    if days.empty?
      tr.css("td.padding6").each_with_index do |day,didx|
        day.xpath("//td[@id]").each do |cell|
          time = cell.css("div.time").first.text.strip
          prog = cell.css("div.caption a").first.text.strip
          data << [cidx, didx, time, prog]
        end
      end
    end
  end
  
end

pp cnt

File.open('data.rb','w:utf-8') {|f| f.write data.pretty_inspect }
