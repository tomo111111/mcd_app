class SaleCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations

  SALES_NUM = Date.today.end_of_month.day  # 同時に作成する数
  attr_accessor :collection # ここに作成したモデルが格納される

  # 初期化メソッド
  def initialize(attributes = [])
    self.collection = if attributes.present?
                        attributes.map do |value|
                          Sale.new(
                            plan: value['plan'],
                            actual: value['actual'],
                            date: value['date'],
                            user_id: value['user_id']
                          )
                        end
                      else
                        SALES_NUM.times.map { Sale.new }
                      end
  end

  # レコードが存在するか確認するメソッド
  def persisted?
    false
  end

  # コレクションをDBに保存するメソッド
  def save
    is_success = true
    ActiveRecord::Base.transaction do
      collection.each do |result|
        # バリデーションを全てかけたいからsave!ではなくsaveを使用
        is_success = false unless result.save
      end
      # バリデーションエラーがあった時は例外を発生させてロールバックさせる
      raise ActiveRecord::RecordInvalid unless is_success
    end
  rescue StandardError
    p 'エラー'
  ensure
    return is_success
  end
end
