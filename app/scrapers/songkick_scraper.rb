class SongkickScraper
  URL = 'https://www.songkick.com/metro-areas/6404-us-denver/tonight'.freeze

  URL2 = 'https://www.songkick.com/metro-areas/6404-us-denver'.freeze

  def self.shows
    events = Connection.c_req(URL2)
    shows = []
    events.css('.event-listings-element').each do |event|
      show = {}
      show[:band] = event.css('strong').text
      show[:date] = event.css('time').first.attributes['datetime'].content.to_date
      show[:venue] = event.css('.venue-link').text
      shows << show
    end
    shows
  end
end
