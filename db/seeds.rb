# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

7.times do |i|
  5.times do |e|
    Inventory.create(order:6,use:6,stock:3,date:Date.today - 7 + i,item_id:e,user_id:1)
  end
end

2.times do |i|
  5.times do |e|
    Inventory.create(order:6,date:Date.today + i,item_id:e,user_id:1)
  end
end

Comment.create(text:"test",date:Date.today - 7,user_id:1)
Comment.create(text:"◯◯バーガー新発売！",date:Date.today - 4,user_id:1)
Comment.create(text:"ポテト全サイズ150円！",date:Date.today - 2,user_id:1)
Comment.create(text:"祝日なので発注注意！",date:Date.today - 0,user_id:1)
Comment.create(text:"ナゲット15P390円！",date:Date.today + 1,user_id:1)
Comment.create(text:"子供用おもちゃ入れ替え",date:Date.today + 4,user_id:1)