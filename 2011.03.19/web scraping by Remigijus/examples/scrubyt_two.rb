require 'rubygems'
require 'scrubyt'

unless ARGV.size == 1
  puts "Please specify one and only one state postal code"
  exit 1
end

opc = Scrubyt::Extractor.define do
  fetch 'http://www.opc.org/locator.html'
  select_option 'state', ARGV[0]
  submit
  
  church do
    name 'PROVIDENCE'
    location 'Charlottesville, VA'
  end.ensure_presence_of_attribute :class => 'datarow'
end

opc.to_xml.write($stdout, 1)
Scrubyt::ResultDumper.print_statistics(opc)
opc.export(__FILE__)
