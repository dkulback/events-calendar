class NewmanScraper
  URL = 'https://newmancenterpresents.com/events/'.freeze

  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//li[@class='event-list-item']").each do |event|
      show = {}
      date = event.css("[class='meta-data alt']").css('div')[2].text.squish
      show[:band] = event.css('h3').text.squish
      show[:date] = date.to_date
      show[:venue] = event.css("[class='meta-data alt']").css('div')[1].text.squish
      show[:doors] = event.css("[class='meta-data alt']").css('div')[3].text.squish
      show[:tickets] = event.css('.pull-right').css('a')[0]['href']
      shows << show
    end
    shows
  end
end
