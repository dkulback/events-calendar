class GothicScraper
  URL = 'https://do303.com/venues/gothic-theatre'.freeze
  def self.shows
    events = Connection.get_url(URL)
    events.xpath("//div[@class='ds-events-group']").each do |event|
      show = {}
      date = event.css('.ds-list-break-date').text.to_date
      show[:band] = event.css('.ds-listing-event-title-text').text.squish
      show[:date] = date.to_date
      show[:doors] = event.css("[class='ds-event-time dtstart']").text.squish
      if !event.css("[class='ds-listing event-card ds-event-category-music']").empty?
        show[:tickets] =
          'do303.com' + event.css("[class='ds-listing event-card ds-event-category-music']").css('a')[0]['href']
      else
        show[:tickets] =
          'do303.com' + event.css("[class='ds-listing event-card ds-event-category-comedy']").css('a')[0]['href']
      end
      show[:venue] = event.css('.ds-venue-name').text.squish
      Show.find_or_create_by(show)
    end

    events = Connection.get_url(URL + '?page=2')
    events.xpath("//div[@class='ds-events-group']").each do |event|
      show = {}
      date = event.css('.ds-list-break-date').text.to_date
      show[:band] = event.css('.ds-listing-event-title-text').text.squish
      show[:date] = date.to_date
      show[:doors] = event.css("[class='ds-event-time dtstart']").text.squish
      if !event.css("[class='ds-listing event-card ds-event-category-music']").empty?
        show[:tickets] =
          'do303.com' + event.css("[class='ds-listing event-card ds-event-category-music']").css('a')[0]['href']
      else
        show[:tickets] =
          'do303.com' + event.css("[class='ds-listing event-card ds-event-category-comedy']").css('a')[0]['href']
      end
      show[:venue] = event.css('.ds-venue-name').text.squish
      Show.find_or_create_by(show)
    end
  end
end
