require 'rubygems'
require 'mechanize'

agent = WWW::Mechanize.new

page = agent.get 'http://www.gmail.com'
form = page.forms.first
form.Email = ''
form.Passwd = ''
page = agent.submit form

puts page.body
exit
# search("//meta").first.attributes['href'].gsub(/'/,'') #'

page = agent.get page.search("//meta").first.attributes['href'].gsub(/'/,'') #'
page = agent.get page.uri.to_s.sub(/\?.*$/, "?ui=html&zy=n")
page.search("//tr[@bgcolor='#ffffff']")  do |row|
  from, subject = *row.search("//b/text()")
  url = page.uri.to_s.sub(/ui.*$/, row.search("//a").first.attributes["href"])
  puts "From: #{from}\nSubject: #{subject}\nLink: #{url}\n\n"

  # email = agent.get url
  # p email
end
