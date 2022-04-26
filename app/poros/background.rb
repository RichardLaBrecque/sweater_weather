class Background
  attr_reader :id, :image
  def initialize(hash, location)
    @id
    @image = { location: location,
              image_url: hash[:photos][0][:url],
              credit: { provided_by: "https://www.pexels.com",
                        photographer: hash[:photos][0][:photographer],
                        photographer_url: hash[:photos][0][:photographer_url]}

    }
  end
end
