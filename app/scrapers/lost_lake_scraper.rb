class LostLakeScraper
  URL = 'https://lost-lake.com/events/'
  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='col-12 eventWrapper rhpSingleEvent py-4 px-0']").each do |event|
      show = {}
      show[:band] = event.css('a').css('h2')&.text&.squish
      next if show[:band].include?('PRIVATE')

      show[:date] = event.css('a').css('#eventDate')&.text&.squish
      show[:venue] = event.css('a').css('.venueLink')&.text&.squish
      show[:doors] = event.css("[class='eventDateDetails mt-md-0 mb-md-2']")&.text&.squish
      show[:date] = show[:date].to_date
      show[:tickets] = event.css("[class='btn btn-primary btn-md d-block w-100']")[0]['href']
      shows << show
    end
    shows
  end
end
