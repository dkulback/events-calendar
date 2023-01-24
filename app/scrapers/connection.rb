class Connection
  def self.get_url(url)
    conn = Faraday.new(url: url)
    response = conn.get
    Nokogiri::HTML(response.body)
  end
end
