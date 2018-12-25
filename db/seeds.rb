# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(:name => "匿名シルペディア", :email => "shiru.p.aa@m.titech.ac.jp", :password => 'shirupedia98', :password_confirmation => 'shirupedia98')
Profile.create(user_id: user1.id, avatar: File.open("./public/shirupedia_q_info.png"), token: SecureRandom.hex(12))

question1 = Question.create(:title => "微分方程式(1)の解法が分かりません", :user_id => user1.id, :field_list => ['微分方程式,院試,数学相談室,数学'], :aasm_state => 'wanted')
Cover.create(:photo_message => File.open("./public/sample_q1.jpg"), coverable_id: question1.id, coverable_type: 'Question')
