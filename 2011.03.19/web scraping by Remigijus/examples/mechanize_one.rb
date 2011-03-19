require 'rubygems'
require 'mechanize'
require 'builder'

unless ARGV.size == 1
  puts "Please specify one and only one state postal code"
  exit 1
end

agent = WWW::Mechanize.new
page = agent.get 'http://www.opc.org/locator.html'
form = page.forms.action('locator.html')
form.fields.name("state").options.text(ARGV[0]).first.select
result = form.submit

b = Builder::XmlMarkup.new(:indent => 2)
b.root {
  result.root.search("tr.datarow").each do |row|
    b.church {
      b.name row.at('td[1]').inner_text.strip
      b.location row.at('td[2]').inner_text.strip
    }
  end
}
puts b.to_s
