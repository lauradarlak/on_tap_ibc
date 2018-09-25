# require_relative 'scraper.rb'

class OnTapIbc::Beer
  attr_accessor :name, :abv, :short_desc, :style, :long_desc, :hops

  @@all = []

  def initialize(beer_hash)
    beer_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_menu(current_beers)
    current_beers.each {|beer| self.new(beer)}
  end

  def self.assign_beer(selected_tap)
      @beer_detail_hash = OnTapIbc::Scraper.scrape_core_beliefs.find{|k, v| k == selected_tap.name }
    
      # add_beer_details(beer_detail_hash)
      @beer_detail_hash[1].each do |attribute, data|
        selected_tap.send(("#{attribute}="), data)
      end
  end

  # def self.add_beer_details(beer_detail_hash)
  #     beer_detail_hash[1].each do |attribute, data|
  #       self.send(("#{attribute}="), data)
  #   end
  # end

  def self.all
    @@all
  end


end
