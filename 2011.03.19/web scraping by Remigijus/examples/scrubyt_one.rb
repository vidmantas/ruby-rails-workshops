require("rubygems")
require("scrubyt")

opc = Scrubyt::Extractor.define do
  fetch("http://www.opc.org/locator.html")
  select_option("state", ARGV[0])
  submit
  
  church("/html/body/table/tr/td/table/tr/td/p/table/tr", { :generalize => true }) do
    name("/td[1]/a[1]")
    location("/td[2]")
  end.ensure_presence_of_attribute({:class=>"datarow"})
end

opc.to_xml.write($stdout, 1)
