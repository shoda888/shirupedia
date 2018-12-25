class Ogp
  attr_accessor :description, :title, :image

  def initialize(hash)
    self.description = hash[:description]
    self.title = hash[:title]
    self.image = hash[:image]
  end
end
