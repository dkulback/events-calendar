class Connection
  def self.get_url(url)
    conn = Faraday.new(url: url).get
    Nokogiri::HTML(conn.body)
  end
end
