class HidiveScraper
  URL = 'https://www.eventbrite.com/d/co--denver/hi-dive/'
  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='search-event-card-wrapper']").each do |event|
      venue = event.xpath("//*[@id='root']/div/div[2]/div/div/div/div[1]/div/main/div/div/section[1]/div/section/div/div/section[2]/ul/li[3]/div/section/div/section[1]/div/p[2]").text
      next unless venue == 'Hi-Dive • Denver, CO'

      show = {}
      date = event.css('.eds-event-card-content__primary-content').css('div').last.text
      if date.include?('Today')
        date = Date.today
      elsif date.include?('Tomorrow')
        date = Date.today.tomorrow
      end
      show[:band] = event.css("[class='eds-is-hidden-accessible']").css('div').text
      show[:date] = date.to_date unless date.blank?
      show[:venue] = venue
      show[:tickets] = event.css('a')[0]['href']
      shows << show
      require 'pry'
      binding.pry
    end

    events = Connection.get_url('https://www.eventbrite.com/d/co--denver/hi-dive/?page=2')
    events.xpath("//div[@class='eds-event-card-content__content__principal']").each do |event|
      venue = event.css("[class='card-text--truncated__one']").text.squish
      next unless venue == 'Hi-Dive • Denver, CO'

      show = {}
      date = event.css('.eds-event-card-content__primary-content').css('div').last.text
      if date.include?('Today')
        date = Date.today
      elsif date.include?('Tomorrow')
        date = Date.today.tomorrow
      end
      show[:band] = event.css("[class='eds-is-hidden-accessible']").css('div').text
      show[:date] = date.to_date unless date.blank?
      show[:venue] = venue
      show[:tickets] = event.css('a')[0]['href']
      shows << show
    end
    shows
  end
end
