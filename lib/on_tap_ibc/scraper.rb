require 'nokogiri'
require 'open-uri'

# require_relative 'beer.rb'

class OnTapIbc::Scraper

  # def initialize(url = nil)
  #   @url = url
  # end

  def self.updated_last
    doc = Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))
    updated_last = doc.search("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-section-title").text.strip
    updated_last
  end

  def scrape_menu
    @doc = Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))

    @doc.search("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-items div.menu-item").each do |beer|

      # new_beer = OnTapIbc::Beer.new # create beer instance

      name = beer.css("div.menu-item-title").text.strip # assign beer name
      abv = beer.css("span.menu-item-price-top").text.strip # assign ABV
      short_desc = beer.css("div.menu-item-description").text.strip # assign short description
      OnTapIbc::Beer.create(name, abv, short_desc)

    end

  end

  def scrape_urls
    @doc = Nokogiri::HTML(open("https://www.ithacabeer.com/beers/"))
    @doc.search("div.intrinsic a").each do |url|
      beer_page = OnTapIbc::BeerPage.new
      beer_page.url = url["href"]
      beer_page.save

    end
  end

  def self.scrape_profile(selected_tap)
    doc = Nokogiri::HTML(open("https://www.ithacabeer.com" + selected_tap.url))
    # doc = Nokogiri::HTML(open("https://www.ithacabeer.com/ithaca-beer-core-beliefs#flowerpower"))
    # doc.search("div.col.sqs-col-10.span-10").each do |beer|
      beer = doc.css("div.col.sqs-col-10.span-10")
      selected_tap.style = beer.css("div p.beerDetails2").text.strip
      selected_tap.long_desc = beer.css("div.html-block p").text.strip
      selected_tap.hops = beer.css('strong')[0].next.text.strip
  end

end
