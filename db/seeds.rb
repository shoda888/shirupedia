# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(:name => "正田孝平", :email => "shoda.k.aa@m.titech.ac.jp", :chip => 500)
profile = Profile.create(grade: '学部四年', lesson: 'プログラミング演習', department: '制御システム系', user_id: user.id)

5.times do |no|
  Question.create(:title => "授業に関する質問#{no + 1}", :content => "Q#{no + 1}が分かりません", :user_id => user.id)
end
