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

  def add_beer_details(details_hash)
    details_hash.each do |beer, beer_details_hash|
      beer_details_hash.each do |attribute, data|
        self.send(("#{attribute}="), data)
      end
    end
  end

  def self.all
    @@all
  end


end
