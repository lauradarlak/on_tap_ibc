require_relative 'beer_page.rb'

class OnTapIbc::Beer
  attr_accessor :name, :abv, :short_desc, :url, :concat_name, :style, :long_desc, :hops

  @@all = []

  def initialize(name,abv,short_desc,concat_name = nil)
    self.name = name
    self.abv = abv
    self.short_desc = short_desc
    @concat_name = self.name.downcase.gsub!(/\s/, "")
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name,abv,short_desc,concat_name = nil)
   beer = self.new(name,abv,short_desc,concat_name = nil)
   beer.save
   OnTapIbc::BeerPage.url(beer)
 end





end
