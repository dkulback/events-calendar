class CalendarClient
  GOOGLE_API_URL = 'https://www.googleapis.com'
  TIMEZONE = 'America/Denver'

  class << self
    def insert_event(user, show)
      token = user.google_access_token
      response = post_event(token, show)

      if response.status == 401
        refreshed = refresh_access_token(user.google_refresh_token)
        user.update!(
          google_access_token: refreshed[:access_token],
          token_expires_at: refreshed[:expires_at]
        )

        response = post_event(refreshed[:access_token], show)
      end

      raise "Google Calendar API error: #{response.status}" unless response.success?

      JSON.parse(response.body)
    end

    def refresh_access_token(refresh_token)
      response = Faraday.post('https://oauth2.googleapis.com/token', {
                                client_id: ENV['GOOGLE_CLIENT_ID'],
                                client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                                refresh_token: refresh_token,
                                grant_type: 'refresh_token'
                              })

      body = JSON.parse(response.body)
      {
        access_token: body['access_token'],
        expires_at: Time.current + body['expires_in'].to_i
      }
    end

    private

    def post_event(token, show)
      connection(token).post('/calendar/v3/calendars/primary/events') do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = build_event(show).to_json
      end
    end

    def connection(token)
      Faraday.new(url: GOOGLE_API_URL) do |faraday|
        faraday.headers['Authorization'] = "Bearer #{token}"
        faraday.request :json
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def build_event(show)
      {
        summary: show.band,
        description: show.venue,
        start: {
          dateTime: (show.date + 7.hours).strftime('%FT%T.%NZ'),
          timeZone: TIMEZONE
        },
        end: {
          dateTime: (show.date + 10.hours).strftime('%FT%T.%NZ'),
          timeZone: TIMEZONE
        },
        reminders: {
          useDefault: true
        }
      }
    end
  end
end
