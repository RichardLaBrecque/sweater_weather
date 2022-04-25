class MunchieService
  def self.conn
    Faraday.new(url: "https://api.yelp.com/v3/businesses") do |faraday|
      faraday.headers[:Authorization] = ENV['yelp_key']
    end

  end
  def self.get_munchies_at(location, food)
   response = conn.get("search") do |search|
     search.params[:location] = location
     search.params[:term] = food
   end
  wip = JSON.parse(response.body, symbolize_names: true)
  binding.pry
  end
end
