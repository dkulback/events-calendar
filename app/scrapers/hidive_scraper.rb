class HidiveScraper
  URL = 'https://www.eventbrite.com/d/co--denver/hi-dive/'
  def self.shows
    events = Connection.get_url(URL)
    shows = []
    events.xpath("//div[@class='Container_root__16e3w NestedActionContainer_root__1jtfr event-card event-card__horizontal horizontal-event-card__action-visibility']").each do |event|
      venue = event.css('.Typography_root__4bejd.Typography_body-md__4bejd.event-card__clamp-line--one.eds-text-color--ui-600.Typography_align-match-parent__4bejd')[1].text

      next unless venue.include?('HI') || venue.include?('Hi')

      date = event.css('.Typography_root__4bejd.Typography_body-md__4bejd.event-card__clamp-line--one.eds-text-color--ui-600.Typography_align-match-parent__4bejd')[0].text.squish.gsub(
        '•', ''
      )
      show = {}
      if date.include?('Today')
        date = Date.today
      elsif date.include?('Tomorrow')
        date = Date.today.tomorrow
      end
      show[:band] = event.css('h2').text
      show[:date] = date.to_date unless date.blank?
      show[:venue] = venue
      shows << show
    end

    events = Connection.get_url('https://www.eventbrite.com/d/co--denver/hi-dive/?page=2')
    events.xpath("//div[@class='Container_root__16e3w NestedActionContainer_root__1jtfr event-card event-card__horizontal horizontal-event-card__action-visibility']").each do |event|
      venue = event.css('.Typography_root__4bejd.Typography_body-md__4bejd.event-card__clamp-line--one.eds-text-color--ui-600.Typography_align-match-parent__4bejd')[1].text

      next unless venue.include?('HI') || venue.include?('Hi')

      date = event.css('.Typography_root__4bejd.Typography_body-md__4bejd.event-card__clamp-line--one.eds-text-color--ui-600.Typography_align-match-parent__4bejd')[0].text.squish.gsub(
        '•', ''
      )
      show = {}
      if date.include?('Today')
        date = Date.today
      elsif date.include?('Tomorrow')
        date = Date.today.tomorrow
      end
      show[:band] = event.css('h2').text
      show[:date] = date.to_date unless date.blank?
      show[:venue] = venue
      shows << show
    end
    shows
  end
end
