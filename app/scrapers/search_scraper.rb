class SearchScraper
  def self.shows(venue)
    venue.gsub!(' ', '+')
    url = "https://www.eventbrite.com/d/co--denver/#{venue}/"
    events = Connection.get_url(url)
    shows = []
    events.css('article').each do |event|
      venue_name = event.css("[class='card-text--truncated__one']").text.squish
      next unless venue_name.include?(venue.capitalize)

      show = {}
      date = event.css('.eds-event-card-content__primary-content').css('div').last.text
      if date.include?('Today')
        date = Date.today
      elsif date.include?('Tomorrow')
        date = Date.today.tomorrow
      end
      show[:band] = event.css("[class='eds-is-hidden-accessible']").css('div').text
      show[:date] = date.to_date unless date.blank?
      show[:venue] = venue_name
      show[:tickets] = event.css('a')[0]['href']
      shows << show
    end

    events = Connection.get_url("#{url}?page=2")
    events.xpath("//div[@class='eds-event-card-content__content__principal']").each do |event|
      venue_name = event.css("[class='card-text--truncated__one']").text.squish
      next unless venue_name == "#{venue} • Denver, CO"

      show = {}
      date = event.css('.eds-event-card-content__primary-content').css('div').last.text
      if date.include?('Today')
        date = Date.today
      elsif date.include?('Tomorrow')
        date = Date.today.tomorrow
      end
      show[:band] = event.css("[class='eds-is-hidden-accessible']").css('div').text
      show[:date] = date.to_date unless date.blank?
      show[:venue] = venue_name
      show[:tickets] = event.css('a')[0]['href']
      shows << show
    end
    shows
  end
end
