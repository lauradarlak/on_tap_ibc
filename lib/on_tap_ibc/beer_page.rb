class OnTapIbc::BeerPage
  attr_accessor :url

  @@all = []

  def self.all
    @@all

  end

  def save
    @@all << self
  end

  def self.url(beer)
    self.all.detect{|link|
      beer.url = link.url if link.url.include?(beer.concat_name)
    }
  end

  # def self.url(beer)
  #   self.all.find do |urls|
  #     if urls.url == "/ithaca-beer-core-beliefs\##{beer.concat_name}"
  #       beer.url = "https://www.ithacabeer.com/ithaca-beer-core-beliefs\##{beer.concat_name}"
  #     elsif urls.url == "/ithaca-beer-random-acts\##{beer.concat_name}"
  #       beer.url = "https://www.ithacabeer.com/ithaca-beer-random-acts\##{beer.concat_name}"
  #     else beer.url = "https://www.ithacabeer.com"
  #     end
  #   end
  # end

end
