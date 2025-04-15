class SongkickScraper
  BASE_URL = 'https://www.songkick.com/metro-areas/6404-us-denver?page=%<page>s#metro-area-calendar'.freeze

  def self.shows
    all_shows = []

    (1..25).each do |page_num|
      url = format(BASE_URL, page: page_num)
      events = Connection.c_req(url)

      events.css('.event-listings-element').each do |event|
        show = {}
        show[:band]  = event.css('strong').text.strip
        show[:date]  = event.css('time').first&.attribute('datetime')&.value&.to_date
        show[:venue] = event.css('.venue-link').text.strip
        all_shows << show
      end
    end

    all_shows
  end
end
