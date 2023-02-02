class BluebirdScraper
  URL = 'https://www.bluebirdtheater.net/events'.freeze
  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='entry  bluebird clearfix ']").each do |event|
      show = {}
      date = event.css('.date').text.squish
      show[:band] = event.css('.title').text.squish
      show[:date] = date.to_date
      show[:doors] = event.css('.time').text.squish
      show[:tickets] = event.css('a')[0]['href']
      show[:venue] = 'Bluebird Theater'
      shows << show
    end
    shows
  end
end
