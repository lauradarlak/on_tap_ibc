require_relative 'beer_page.rb'

class OnTapIbc::Beer
  attr_accessor :name, :abv, :short_desc, :url, :concat_name, :style, :long_desc, :hops

  @@all = []

  # def initialize()
  #   @concat_name
  # end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def name=(name)
   @name = name
   @concat_name = self.name.downcase.gsub!(/\s/, "")
   url
 end

 def url
   OnTapIbc::BeerPage.all.find do |urls|
     if urls.url == "/ithaca-beer-core-beliefs\##{self.concat_name}"
       @url = "https://www.ithacabeer.com/ithaca-beer-core-beliefs\##{self.concat_name}"
     elsif urls.url == "/ithaca-beer-random-acts\##{self.concat_name}"
       @url = "https://www.ithacabeer.com/ithaca-beer-random-acts\##{self.concat_name}"
     else @url = "https://www.ithacabeer.com"
     end
   end
 end


end
