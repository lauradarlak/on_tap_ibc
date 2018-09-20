# require_relative 'scraper.rb'

class OnTapIbc::Beer
  attr_accessor :name, :abv, :short_desc, :url

  @@all = []

  def self.all
    @@all
  end

  def save
    @@all << self

  end
end
