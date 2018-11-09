# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(:name => "正田孝平", :email => "shoda.k.aa@m.titech.ac.jp", :password => 'password', :password_confirmation => 'password')
Profile.create(grade: 'B4', lesson: '連続体の力学', department: '制御システム系', user_id: user1.id, avatar: File.open("./public/user1-128x128.jpg"))

user2 = User.create(:name => "中山実", :email => "nakayama.m.aa@m.titech.ac.jp", :password => 'password', :password_confirmation => 'password')
Profile.create(grade: 'M2', lesson: 'プログラミング演習', department: '情報通信系', user_id: user2.id, avatar: File.open("./public/user2-160x160.jpg"))

question1 = Question.create(:title => "微分方程式(1)の解法が分かりません", :user_id => user1.id, :field_list => ['微分方程式,院試,数学'], :aasm_state => 'wanted')
Cover.create(:photo_message => File.open("./public/sample_q1.jpg"), coverable_id: question1.id, coverable_type: 'Question')
answer1 = Answer.create(question_id: question1.id, user_id: user2.id)
Cover.create(:photo_message => File.open("./public/sample_a1.jpg"), coverable_id: answer1.id, coverable_type: 'Answer')

question2 = Question.create(:title => "なぜ以下のように仮定して解くのですか？", :user_id => user2.id, :field_list => ['力学,運動方程式,解析'], :aasm_state => 'wanted')
Cover.create(:photo_message => File.open("./public/sample_q2.jpg"), coverable_id: question2.id, coverable_type: 'Question')

question3 = Question.create(:title => "この写真の中のデシベルは何を基準にしてますか？意図は、相対単位の基準点というか、デシベルで表そうとしている単位もしくは、0dBのときに何を表しているかというか(例えば0dB=どこかで観測した音量,1eV,or1V)です。何らかのエネルギー値ぽいですね。", :user_id => user1.id, :field_list => ['計測,デシベル,波形,周波数,解析'], :aasm_state => 'wanted')
Cover.create(:photo_message => File.open("./public/sample_q3.jpg"), coverable_id: question3.id, coverable_type: 'Question')
answer3 = Answer.create(question_id: question3.id, user_id: user2.id)
Cover.create(:photo_message => File.open("./public/sample_a3.jpg"), coverable_id: answer3.id, coverable_type: 'Answer')
