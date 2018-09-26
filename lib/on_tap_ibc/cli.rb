class OnTapIbc::CLI

  def start
    puts "What's on tap at Ithaca Beer Company"
    puts "#{OnTapIbc::Scraper.updated_last}"
    make_beers
    list_beers
  end

  def make_beers
    current_beers = OnTapIbc::Scraper.scrape_menu
    OnTapIbc::Beer.create_from_menu(current_beers)
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
    five.map.with_index(nofive.length + 1) do |beer, index|
        puts "#{index}. #{beer.name} - #{beer.abv}"
    end
    puts "Select a tap number to learn more."

    sorted_tap_arr = (nofive + five).flatten
    select_tap(sorted_tap_arr)
  end

  def select_tap(sorted_tap_arr)
    input = gets.to_i
    selected_tap = sorted_tap_arr[input-1]

    OnTapIbc::Beer.assign_beer(selected_tap)
    display_profile(selected_tap)
  end

  def display_profile(selected_tap)
    puts "#{selected_tap.name}"
    if selected_tap.long_desc == nil
      puts "DESCRIPTION #{selected_tap.short_desc}"
      puts "ABV: #{selected_tap.abv}"
    else
      puts "STYLE #{selected_tap.style}"
      puts "DESCRIPTION #{selected_tap.long_desc}"
      selected_tap.addl1.each {|i| puts "#{i}"}
    end
  end

end
