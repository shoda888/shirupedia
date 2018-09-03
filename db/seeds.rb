# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(:name => "正田孝平", :email => "shoda.k.aa@m.titech.ac.jp")
Profile.create(grade: 'B4', lesson: '連続体の力学', department: '制御システム系', user_id: user1.id)

user2 = User.create(:name => "中山実", :email => "nakayama.m.aa@m.titech.ac.jp")
Profile.create(grade: 'M2', lesson: 'プログラミング演習', department: '情報通信系', user_id: user2.id)

question1 = Question.create(:title => "固有振動数の求め方", :user_id => user1.id, :field_list => ['材料力学,物理,解析,ansys'])
question2 = Question.create(:title => "Pythonでロボットの制御ってできるんですか？", :user_id => user1.id, :field_list => ['python,ロボット,プログラミング'])
