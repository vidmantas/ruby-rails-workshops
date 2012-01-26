require 'scrapi'

ebay_auction = Scraper.define do
  process "h3.ens>a", :description=>:text,
                      :url=>"@href"
  process "td.ebcPr>span", :price=>:text
  process "div.ebPicture >a>img", :image=>"@src"
  
  result :description, :url, :price, :image
end


ebay = Scraper.define do
  array :auctions
  
  process "table.ebItemlist tr.single",
          :auctions => ebay_auction
  
  result :auctions
end


# --------------------------
auctions = ebay.scrape(html)

# No. of auctions found
puts auctions.size

# First auction:
auction = auctions[0]
puts auction.description
puts auction.url
