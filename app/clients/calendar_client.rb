class CalendarClient
  def self.get_url(url, token, show)
    conn = Faraday.new(url: 'https://www.googleapis.com') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{token}"
      faraday.request :json
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    event_data = {
      summary: show.band,
      description: show.venue,
      start: {
        dateTime: show.date.strftime('%FT%T.%NZ'),
        timeZone: 'America/Denver'
      },
      end: {
        dateTime: show.date.strftime('%FT%T.%NZ'),
        timeZone: 'America/Denver'
      },
      reminders: {
        useDefault: true
      }
    }
    json_data = event_data.to_json

    conn.post(url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = json_data
    end
  end

  def self.refresh_access_token(token)
    response = Faraday.post('https://oauth2.googleapis.com/token',
                            {
                              client_id: ENV['GOOGLE_CLIENT_ID'],
                              client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                              refresh_token: token,
                              grant_type: 'refresh_token'
                            })
    body = JSON.parse(response.body)
    update(access_token: body['access_token'], expires_at: Time.now + body['expires_in'].to_i)
  end

  def self.insert_event(token, event)
    response = get_url('/calendar/v3/calendars/primary/events', token, event)
    JSON.parse(response.body)
  end
end
