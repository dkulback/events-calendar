class HqScraper
  URL = 'https://www.hqdenver.com/'

  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='event-card']").each do |event|
      show = {}
      date = event.css('.event-date').text.squish
      show[:band] = event.css('.title').text
      show[:date] = date.to_date
      show[:venue] = event.css('.location').text.squish
      show[:doors] = event.css('.event-date').css('.time').text.squish
      show[:tickets] = if event.css('.more-info-btn').css('button')[1].text == 'Free'
                         'FREE'
                       else
                         event.css('.more-info-btn').css('button')[1]['onclick'][13..57]
                       end
      shows << show
    end
    shows
  end
end
