class OnTapIbc::CLI

  def start
    puts "What's on tap at Ithaca Beer Company"
    puts "#{OnTapIbc::Scraper.updated_last}"
    make_beers
    add_beer_details_to_beers
    list_beers
  end

  def make_beers
    current_beers = OnTapIbc::Scraper.scrape_menu
    OnTapIbc::Beer.create_from_menu(current_beers)
  end

  def add_beer_details_to_beers
    OnTapIbc::Beer.all.each do |beer|
      attributes = OnTapIbc::Scraper.scrape_detail_pages
      beer.add_beer_details(attributes)
    end
  end

  def list_beers

    five = []
    nofive = []
    OnTapIbc::Beer.all.each do |beer|
      beer.short_desc.include?("5BBL") ? five << beer : nofive << beer
    end
    puts "Flagship and Seasonal Beers"
    nofive.map.with_index(1) do |beer, index|
      puts "#{index}. #{beer.name} - #{beer.abv}"
    end
    puts "----------------------------"
    puts "5 Barrel Brews"
    five.map.with_index(1) do |beer, index|
        puts "#{index}. #{beer.name} - #{beer.abv}"
    end

  end



end
