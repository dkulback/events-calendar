class SwallowHillScraper
  URL = 'https://swallowhillmusic.org/concerts/'.freeze
  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='tribe-events-calendar-list__event-wrapper tribe-common-g-col']").each do |event|
      show = {}
      date = event.css('time').text.squish
      show[:band] = event.css('h3').text.squish
      show[:tickets] = event.css('h3').css('a')[0].text.squish
      show[:date] = date.to_date
      show[:doors] = event.css('.time').text.squish
      show[:venue] = 'Swallowhill Music'
      shows << show
    end
    shows
  end
end
