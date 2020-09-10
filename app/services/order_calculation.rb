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
          # なければ仮でケース単価50000とする
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
    day_after_tomorrow_inventory = Inventory.find_by(date:date + 2,item_id:item.id,user_id:item.user_id)
    # すでに翌々日の納品数が決まっている場合（当日のデータを際入力した場合など）はupdate、通常通りの手順ならcreate
    if day_after_tomorrow_inventory
      day_after_tomorrow_inventory.update(order:day_after_tomorrow_order.round(2))
    else
      Inventory.create(order:day_after_tomorrow_order.round(2),date:date + 2,item_id:item.id,user_id:item.user_id)
    end
  end

end