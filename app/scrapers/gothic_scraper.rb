class GothicScraper
  URL = 'https://do303.com/venues/gothic-theatre'.freeze
  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='ds-events-group']").each do |event|
      show = {}
      date = event.css('.ds-list-break-date').text.to_date
      show[:band] = event.css('.ds-listing-event-title-text').text.squish
      show[:date] = date.to_date
      show[:doors] = event.css("[class='ds-event-time dtstart']").text.squish
      show[:tickets] = 'do303.com' + event.css('div')[2]['data-permalink']
      show[:venue] = event.css('.ds-venue-name').text.squish
      shows << show
    end

    events = Connection.get_url(URL + '?page=2')
    events.xpath("//div[@class='ds-events-group']").each do |event|
      show = {}
      date = event.css('.ds-list-break-date').text.to_date
      show[:band] = event.css('.ds-listing-event-title-text').text.squish
      show[:date] = date.to_date
      show[:doors] = event.css("[class='ds-event-time dtstart']").text.squish
      show[:tickets] = 'do303.com' + event.css('div')[2]['data-permalink']
      show[:venue] = event.css('.ds-venue-name').text.squish
      shows << show
    end
    shows
  end
end
