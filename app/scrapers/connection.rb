class Connection
  OUTPUT = 'output.html'
  def self.get_url(url)
    conn = Faraday.new(url: url)
    response = conn.get
    Nokogiri::HTML(response.body)
  end

  def self.c_req(url)
    _stdout, stderr, status = Open3.capture3("curl -o #{OUTPUT} #{url}")
    if status.success?
      file = File.open(OUTPUT)
      doc = Nokogiri::HTML(file)
      file.close
      doc
    else
      puts "Error fetching HTML: #{stderr}"
    end
  end
end
