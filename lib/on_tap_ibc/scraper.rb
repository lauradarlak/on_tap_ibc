require 'nokogiri'
require 'open-uri'

# require_relative 'beer.rb'

class OnTapIbc::Scraper

  def self.updated_last
    doc = Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))
    updated_last = doc.search("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-section-title").text.strip
    updated_last
  end

  def self.scrape_menu
    beers = Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))
    current_beers = []
    # Iterate through beer menu
    beers.css("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-items div.menu-item").each do |beer|

      current_beers << {
        :name => beer.css("div.menu-item-title").text.strip, # assign beer name
        :abv => beer.css("span.menu-item-price-top").text.strip, # assign ABV
        :short_desc => beer.css("div.menu-item-description").text.strip # assign short description
      }
    end
    current_beers
  end

  # def self.scrape_core_beliefs
  #     # ["https:///www.ithacabeer.com/ithaca-beer-core-beliefs", "https://www.ithacabeer.com/ithaca-beer-random-acts"].each do |url|
  #
  #     beers = Nokogiri::HTML(open("https://www.ithacabeer.com/ithaca-beer-core-beliefs"))
  #     beer_hash = {}
  #     beers.css("div.col.sqs-col-10.span-10").each do |beer|
  #       beer_hash[:name] = beer.css("div p.beerDetails").text.strip
  #       beer_hash[:name][:style] = beer.css("div p.beerDetails2").text.strip
  #       beer_hash[:name][:long_desc] = beer.css("div.html-block p").text.strip
  #       # beer_hash[:hops] = beer.css("div.html-block p")[1].text.strip
  #     end
  #   beer_hash
  # end

  def self.scrape_core_beliefs
      ["https://www.ithacabeer.com/ithaca-beer-core-beliefs","https://www.ithacabeer.com/ithaca-beer-random-acts"].each do |url|

      beers = Nokogiri::HTML(open(url))
      beer_hashes = {}
      beers.css("div.col.sqs-col-10.span-10").each do |beer|

      beer_hashes["#{beer.css("div p.beerDetails").text.strip}"] = {
        name: beer.css("div p.beerDetails").text.strip,
        style: beer.css("div p.beerDetails2").text.strip,
        long_desc: beer.css("div.html-block p").text.strip
      }
      end
      
      beer_hashes
    end

  end

end
