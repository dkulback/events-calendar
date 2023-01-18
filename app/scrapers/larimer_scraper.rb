class LarimerScraper
  URL = 'https://larimerlounge.com/events/'
  def self.larimer_shows
    events = Connection.get_url(URL)
    shows_array = []
    events.xpath("//div[@class='col-12 eventWrapper rhpSingleEvent py-4 px-0']").each do |event|
      show = {}
      show[:band] = event.css('a').css('h2')&.text&.squish
      show[:date] = event.css('a').css('#eventDate')&.text&.squish
      show[:venue] = event.css('a').css('.venueLink')&.text&.squish
      show[:doors] = event.css("[class='eventDateDetails mt-md-0 mb-md-2']")&.text&.squish
      show[:date] = show[:date].to_date
      Show.find_or_create_by(show)
    end
  end
end
