class OnTapIbc::CLI

  def start
    puts "What's on tap at Ithaca Beer Company"
    puts "#{OnTapIbc::Scraper.updated_last}"
    puts "----------------------------"
    puts "----------------------------"
    puts "Enter the number of a tap to learn more."

    list_beers
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

      sorted_tap_arr = (nofive + five).flatten
      select_tap(sorted_tap_arr)
  end

  def select_tap(sorted_tap_arr)
    input = gets.to_i
    selected_tap = sorted_tap_arr[input-1]
    OnTapIbc::Scraper.scrape_profile(selected_tap)
    display_profile(selected_tap)
  end

  def display_profile(selected_tap)
    puts "#{selected_tap.style}"
    # puts "#{selected_tap.long_desc}"
  end

end
