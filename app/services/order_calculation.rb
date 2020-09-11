class OrderCalculation

  def self.calculation(item,date)
    unit_all = []
    7.times do |i|
      inventory = Inventory.find_by(date:date - i,item_id:item.id,user_id:item.user_id)
      sale = Sale.find_by(date:date - i,user_id:item.user_id)
      # i日前の在庫情報があれば
      if inventory
        unit = sale.actual / inventory.use
        unit_all << unit
      # i日前の在庫情報がなければ
      else
        # ケース単価情報が1日分でもあれば
        if unit
          unit_all << unit
        else
          # 1日分もなければ仮でケース単価50000とする
          unit = 50000
          unit_all << unit
        end
      end
    end
    # 翌々日（納品日）の曜日によって参考にするケース単価を変更する
    # ave_unit_2は翌々日の使用数算出用
    # ave_unit_1は翌日の使用数算出用
    case %w[日 月 火 水 木 金 土][(date + 2).wday]
      when "月"
        ave_unit_2 = (unit_all[1] + unit_all[2] + unit_all[3]) / 3
        ave_unit_1 = (unit_all[0] + unit_all[6]) / 2
      when "火"
        ave_unit_2 = (unit_all[1] + unit_all[2] + unit_all[3]) / 3
        ave_unit_1 = (unit_all[2] + unit_all[3] + unit_all[4]) / 3
      when "水"
        ave_unit_2 = (unit_all[0] + unit_all[3] + unit_all[4]) / 3
        ave_unit_1 = (unit_all[0] + unit_all[3] + unit_all[4]) / 3
      when "木"
        ave_unit_2 = (unit_all[0] + unit_all[1] + unit_all[4]) / 3
        ave_unit_1 = (unit_all[0] + unit_all[1] + unit_all[4]) / 3
      when "金"
        ave_unit_2 = (unit_all[0] + unit_all[1] + unit_all[2]) / 3
        ave_unit_1 = (unit_all[0] + unit_all[1] + unit_all[2]) / 3
      when "土"
        ave_unit_2 = (unit_all[4] + unit_all[5]) / 2
        ave_unit_1 = (unit_all[0] + unit_all[1] + unit_all[2]) / 3
      when "日"
        ave_unit_2 = (unit_all[5] + unit_all[6]) / 2
        ave_unit_1 = (unit_all[5] + unit_all[6]) / 2
    end
    # 翌日の使用数算出
    tomorrow_sale = Sale.find_by(date:date + 1,user_id:item.user_id)
    tomorrow_use = tomorrow_sale.plan / ave_unit_1
    # 翌々日の納品数算出
    inventory = Inventory.find_by(date:date,item_id:item.id,user_id:item.user_id)
    tomorrow_inventory = Inventory.find_by(date:date + 1,item_id:item.id,user_id:item.user_id)
    day_after_tomorrow_sale = Sale.find_by(date:date + 2,user_id:item.user_id)
    day_after_tomorrow_use = day_after_tomorrow_sale.plan / ave_unit_2
    day_after_tomorrow_order = item.margin + day_after_tomorrow_use + tomorrow_use - tomorrow_inventory.order - inventory.stock
    if day_after_tomorrow_order < 0
      day_after_tomorrow_order = 0
    end

    # 翌々日のinv情報を取得（nilの場合もある）
    day_after_tomorrow_inventory = Inventory.find_by(date:date + 2,item_id:item.id,user_id:item.user_id)
    # 配送有りの曜日を全て取得
    deliveries = Delivery.where(check: 1,user_id:item.user_id)
    # 配送有りの曜日を配列に代入
    array_deliveries =[]
    deliveries.each do |delivery|
      array_deliveries << delivery.day_of_week
    end

    # 翌々日が配送有りの曜日だったら
    if array_deliveries.include?(%w[Sun. Mon. Tue. Wed. Thu. Fri. Sat.][(date + 2).wday])
      # 3日後が配送有りの曜日だったら
      if array_deliveries.include?(%w[Sun. Mon. Tue. Wed. Thu. Fri. Sat.][(date + 3).wday])
        # すでに翌々日の納品数が決まっている場合（当日のデータを再入力した場合など）はupdate、通常通りの手順ならcreate
        if day_after_tomorrow_inventory
          day_after_tomorrow_inventory.update(order:day_after_tomorrow_order.round)
        else
          Inventory.create(order:day_after_tomorrow_order.round,date:date + 2,item_id:item.id,user_id:item.user_id)
        end
      # 3日後が配送無しの曜日だった場合の処理
      else
        if day_after_tomorrow_inventory
          day_after_tomorrow_inventory.update(order:(day_after_tomorrow_order * 2 - item.margin).round)
        else
          Inventory.create(order:(day_after_tomorrow_order * 2 - item.margin).round,date:date + 2,item_id:item.id,user_id:item.user_id)
        end
      end
      # 翌々日が配送無しの曜日だったら
    else
      if day_after_tomorrow_inventory
        day_after_tomorrow_inventory.update(order:0)
      else
        Inventory.create(order:0,date:date + 2,item_id:item.id,user_id:item.user_id)
      end
    end
  end
end