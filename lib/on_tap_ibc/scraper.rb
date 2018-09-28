class OnTapIbc::Scraper

  def self.doc
    @doc ||= Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))
  end

  def self.updated_last
    puts "**********Scraping Update"
    # doc = Nokogiri::HTML(open("https://www.ithacabeer.com/taproom-menu/#anchor-tap-list"))
    beers = self.doc
    updated_last = beers.search("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-section-title").text.strip
    updated_last
  end

  def self.scrape_menu
    puts "**********Scraping Menu"
    beers = self.doc
    current_beers = []
    # Iterate through beer menu
    beers.css("div#block-yui_3_17_2_8_1508769314339_15193 div.menu-items div.menu-item").each do |beer|

      current_beers << {
        :name => beer.css("div.menu-item-title").text.strip,
        :abv => beer.css("span.menu-item-price-top").text.strip,
        :short_desc => beer.css("div.menu-item-description").text.strip
      }
    end
    current_beers
  end

  def self.beer_details(tap)
      beer_hashes = {}
      ["https://www.ithacabeer.com/ithaca-beer-core-beliefs","https://www.ithacabeer.com/ithaca-beer-random-acts"].each do |url|
    puts "************Scraping Core Belief*********"
          beers = Nokogiri::HTML(open(url))

          beers.css("div.col.sqs-col-10.span-10").each do |beer|
            # binding.pry
            if beer.css("div p.beerDetails").text.strip.upcase == tap.name.upcase
              binding.pry
              beer_hashes["#{beer.css("div p.beerDetails").text.strip.upcase}"] = {
                style: beer.css("div p.beerDetails2").text.strip,
                long_desc: beer.css("div.html-block p")[0].text.strip,
                addl1: beer.css("div.html-block p").last.text.strip
              }
              binding.pry
              return beer_hashes
            end
          end
        end
        beer_hashes
      end

end
