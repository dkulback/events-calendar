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
      button = event.css('.more-info-btn button')[1]

      show[:tickets] = if button && button.text == 'Free'
                         'FREE'
                       elsif button
                         button['onclick'][13..57]
                       else
                         # Handle the case when the button doesn't exist
                         'No Button Found'
                       end
      shows << show
    end
    shows
  end
end
