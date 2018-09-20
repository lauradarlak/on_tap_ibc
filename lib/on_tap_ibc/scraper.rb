require 'nokogiri'
require 'open-uri'

require_relative 'beer.rb'

class OnTapIbc::Scraper

  def initialize
  end

  def self.updated_last
    doc = Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))
    updated_last = doc.search("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-section-title").text.strip
    updated_last
  end

  def scrape_menu
    @doc = Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))

    @doc.search("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-items div.menu-item").each do |beer|

      new_beer = OnTapIbc::Beer.new # create beer instance

      new_beer.name = beer.css("div.menu-item-title").text.strip # assign beer name
      new_beer.abv = beer.css("span.menu-item-price-top").text.strip # assign ABV
      new_beer.short_desc = beer.css("div.menu-item-description").text.strip # assign short description
      new_beer.save

    end

  end

end
