class Ogp
  attr_accessor :description, :title, :image, :card

  def initialize(hash)
    self.description = hash[:description]
    self.title = hash[:title]
    self.image = hash[:image]
    self.card = hash[:card]
  end
end
