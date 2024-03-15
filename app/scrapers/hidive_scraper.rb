class HidiveScraper
  URL = 'https://hi-dive.com/'.freeze
  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='item eventColl-item squareImages']").each do |event|
      show = {}
      show[:band] = event.css('h2').css('a').text
      show[:date] = event.css('div').css('span').text.to_date
      show[:tickets] = event.at_css("[class='button eventColl-statusBtn eventColl-statusBtn--buy']")['href']
      show[:venue] = 'Hi-Dive'
      shows << show
    end
    shows
  end
end
