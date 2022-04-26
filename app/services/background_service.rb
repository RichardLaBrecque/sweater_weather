class BackgroundService

  def self.conn
    Faraday.new(url: "https://api.pexels.com/v1") do |faraday|
      faraday.headers["Authorization"] = ENV["background_api_key"]
    end
  end
  def self.get_background_image(location)
    response = conn.get("search?query=#{location}&per_page=1")
   JSON.parse(response.body, symbolize_names: true)

  end
end
