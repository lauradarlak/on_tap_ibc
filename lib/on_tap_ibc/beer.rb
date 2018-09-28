class OnTapIbc::Beer
  attr_accessor :name, :abv, :short_desc, :style, :long_desc, :addl1

  @@all = []

  def initialize(beer_hash)
    beer_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_menu(current_beers)
    current_beers.each {|beer| self.new(beer)}
  end

  def self.assign_beer(selected_tap)

    beer_detail_hash = OnTapIbc::Scraper.beer_details(selected_tap)#.find{|k, v| k == selected_tap.name.upcase }
      if beer_detail_hash != {}
        # binding.pry
        beer_detail_hash[1].each do |attribute, data|
          selected_tap.send(("#{attribute}="), data)
        end
      end
  end


  def addl1=(addl1)
    @addl1 = addl1.split(/(?<=[a-z])(?=[A-Z])/)
  end

  def self.all
    @@all
  end

end
