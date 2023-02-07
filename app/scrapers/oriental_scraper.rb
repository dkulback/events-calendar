class OrientalScraper
  URL = 'https://theorientaltheater.com/'.freeze

  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='event_right_col']").each do |event|
      show = {}
      date = event.css('.event_date').text
      show[:band] = event.css('.event_name').text
      show[:doors] = event.css('.event_info').text
      show[:date] = date.to_date
      show[:venue] = 'Oriental Theater'
      show[:tickets] = event.css('.buttons').css('a')[0]['href'] if event.css('.buttons').css('a')[0]
      shows << show
    end
    shows
  end
end
