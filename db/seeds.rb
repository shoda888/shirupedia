# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(:name => "正田孝平", :email => "shoda.k.aa@m.titech.ac.jp", :chip => 500)
Profile.create(grade: 'B4', lesson: '連続体の力学', department: '制御システム系', user_id: user1.id)

user2 = User.create(:name => "中山実", :email => "nakayama.m.aa@m.titech.ac.jp", :chip => 500)
Profile.create(grade: 'M2', lesson: 'プログラミング演習', department: '情報通信系', user_id: user2.id)

question1 = Question.create(:title => "固有振動数の求め方", :content => "固有振動数について質問です。自分は卒研でansysという解析ソフトを使ってモード解析を行い固有振動数を求めています。しかし、弾性波には縦波と横波があるということを知りました。そこで疑問なのですがこのモード解析で出てきた固有振動数とは、どのような波のことなのでしょうか。縦波、横波または両方当てはまるのでしょうか。教授は振動学の専門ではないため聞くことができません。自分で論文をいくつか調べたのですが縦波が横波より速いということしか出てきませんでした。知っておられる方、何卒教えていただけないでしょうか。",
                :user_id => user1.id, :field_list => ['材料力学,物理,解析,ansys'])
question2 = Question.create(:title => "Pythonでロボットの制御ってできるんですか？", :content => "Pythonでロボットの制御ってできるのですか？", :user_id => user1.id, :field_list => ['python,ロボット,プログラミング'])

Answer.create(:title => '最近ではできるようになっています', :content => "ほんの数年前なら、「ロボット制御ならC言語」とか言う人も居たようだが、もうC言語では太刀打ちできない、高度で複雑なコトまでPython言語でできるようになっているようです。\n
                                                        ・Pythonによる4足歩行ロボットの制御と強化学習\n
                                                        https://www.slideshare.net/takehide22/python4-pyconjp", :user_id => user2.id, :question_id => question2.id)
