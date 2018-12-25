class HomesController < ApplicationController
  layout 'home'

  def top
    @ogp = Ogp.new({ title: "Shirupedia", description: "東工大の学生を対象に授業・講義、学生生活の疑問点を解消するアプリケーション", image: "https://res.cloudinary.com/hnj7qqu7w/image/upload/v1545738853/helloquence-s.jpg", card: "summary_large_image" })
  end
end
