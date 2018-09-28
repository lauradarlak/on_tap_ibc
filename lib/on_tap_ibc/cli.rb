class OnTapIbc::CLI

  def initialize
    @five = []
    @nofive = []
  end

  def start
    welcome
    make_beers
    sort_beers
    list_beers
    goodbye
  end

  def welcome
    puts "-----------------------------------------"
    puts "What's on tap at Ithaca Beer Company"
    puts "#{OnTapIbc::Scraper.updated_last}"
    puts "-----------------------------------------"
  end

  def make_beers
    current_beers = OnTapIbc::Scraper.scrape_menu
    OnTapIbc::Beer.create_from_menu(current_beers)
  end

  def sort_beers
    OnTapIbc::Beer.all.each do |beer|
      beer.short_desc.include?("5BBL") ? @five << beer : @nofive << beer
    end
  end

  def list_beers
    puts "\#.      BEER     -     ABV %"
    puts "-----------------------------------------"
    puts "Flagship and Seasonal Beers"
    @nofive.map.with_index(1) do |beer, index|
      puts "#{index}. #{beer.name} - #{beer.abv}"
    end
    puts "-----------------------------------------"
    puts "5 Barrel Brews"
    @five.map.with_index(@nofive.length + 1) do |beer, index|
        puts "#{index}. #{beer.name} - #{beer.abv}"
    end
    puts "-----------------------------------------"
    puts "Select a tap number to learn more about the beer."
    sorted_tap_arr = (@nofive + @five).flatten
    select_tap(sorted_tap_arr)
  end

  def select_tap(sorted_tap_arr)
    input = nil
    while input != "exit"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= sorted_tap_arr.length
        selected_tap = sorted_tap_arr[input.to_i-1]
    
        OnTapIbc::Beer.assign_beer(selected_tap) if selected_tap.style.nil?

        display_profile(selected_tap)
      else
        puts "Invalid tap number. Please try again."
      end
    end
  end

  def display_profile(selected_tap)
    puts "-----------------------------------------"
    puts "#{selected_tap.name.upcase}"
    puts "-----------------------------------------"
    if selected_tap.long_desc == nil
      puts wrap("DESCRIPTION #{selected_tap.short_desc}")
      puts "ABV #{selected_tap.abv}"
      puts "HOPS N/A"
      puts "DRY HOPS N/A"
      puts "MALTS N/A"
    else
      puts "STYLE #{selected_tap.style}"
      puts wrap("DESCRIPTION #{selected_tap.long_desc}")
      selected_tap.addl1.each {|i| puts "#{i}"}
    end
    new_selection
  end

  def new_selection
    puts "-----------------------------------------"
    puts "Type list to select another beer or exit."
    input = nil
    input = gets.strip.downcase
      if input == "list"
        list_beers
      elsif input == "exit"
        puts "Cheers!"
        exit
      else
        puts "Please try again."
      end
  end

  def wrap(s, width=100)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	end

end
