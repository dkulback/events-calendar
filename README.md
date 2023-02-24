# Denver Local Venue Scraper

This is a web scraper that collects data from local venues in Denver. The scraped data includes venue names, addresses, phone numbers, websites, and upcoming events.

## Setup

### Dependencies

* Ruby 2.7.0
* Rails 7.0.1
* PostgreSQL

### Installation

1. Clone the repository
2. Install dependencies: `bundle install`
3. Create and migrate the database: `rails db:create && rails db:migrate`
4. Set up environment variables:
   * `GOOGLE_CLIENT_ID`
   * `GOOGLE_CLIENT_SECRET`
5. Start the server: `rails s` or 'bin/dev'

### Authentication

This app uses Devise and Google OAuth 2 for authentication. To use Google OAuth 2, you will need to set up a Google Cloud Console project and create OAuth 2 credentials. See [Google's documentation](https://developers.google.com/identity/protocols/oauth2) for instructions.

### Adding Events to User Calendars

This app uses the Google Calendar API to allow users to add events to their Google calendars. To use this feature, you will need to enable the Google Calendar API for your Google Cloud Console project and set up the necessary credentials. See [Google's documentation](https://developers.google.com/calendar/api/v3/quickstart/js) for instructions.

## Usage

### Web Scraper

To run the web scraper, use the following Rake task: `rake scrape_load:all`. Individual venues can be scraped by passing the venue's nameas an argument to the rake task, like so: rake scape_load:['Venue Name']

### Calendar Integration

To add an event to a user's calendar, send a `POST` request to `/shows/:id/add_to_calendar` with the following parameters:
* `access_token`: The user's access token from Google OAuth 2
* `start_time`: The start time of the event in `YYYY-MM-DDTHH:mm:ss` format (e.g. `2023-02-25T19:00:00`)
* `end_time`: The end time of the event in `YYYY-MM-DDTHH:mm:ss` format (e.g. `2023-02-25T22:00:00`)
* `title`: The title of the event
* `location`: The location of the event

## Dependencies

* [Devise](https://github.com/heartcombo/devise) - User authentication
* [Google OAuth 2](https://github.com/zquestz/omniauth-google-oauth2) - Google OAuth 2 authentication
* [Google Calendar API](https://developers.google.com/calendar/api/v3/reference) - Google Calendar API
* [Nokogiri](https://github.com/sparklemotion/nokogiri) - Web scraping
* [PostgreSQL](https://www.postgresql.org/) - Database
* [Tailwind CSS](https://tailwindcss.com/) - CSS framework

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<username>/<repository>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
