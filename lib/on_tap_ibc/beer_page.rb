class OnTapIbc::BeerPage
  attr_accessor :url

  @@all = []

  def self.all
    @@all

  end

  def save
    @@all << self

  end

end
