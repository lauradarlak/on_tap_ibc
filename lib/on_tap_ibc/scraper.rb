require 'nokogiri'
require 'open-uri'

# require_relative 'beer.rb'

class OnTapIbc::Scraper

  def initialize(url = nil)
    @url = url
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

  # def scrape_urls
  #   @doc = Nokogiri::HTML(open("https://www.ithacabeer.com/beers/"))
  #   @doc.search("div.intrinsic a").each do |url|
  #     beer_page = OnTapIbc::BeerPage.new
  #     beer_page.urls = url.attr("href").text
  #     beer_page.save
  #
  #   end
  #
  #
  # end

  def self.scrape_urls
    doc = Nokogiri::HTML(open("https://www.ithacabeer.com/beers/"))
    urls = []

    doc.search("div.intrinsic a").each do |url|
      urls << url.attribute("href").value
    end

    urls

  end

#   def self.assign_urls
#     self.scrape_urls.collect do |url|
#       puts "#{url}"
#     end
#     #   if url.include?("#{OnTapIbc::Beer.new.name.downcase.gsub!(/\s/, "")}")
#     #     OnTapIbc::Beer.name.url = url
#     #   end
#     #   puts "#{OnTapIbc::Beer.name.url}"
#     # end
#   end
# self.assign_urls
end
