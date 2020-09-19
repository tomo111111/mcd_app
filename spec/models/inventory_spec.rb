require 'rails_helper'

RSpec.describe Inventory, type: :model do
  before do
    @inventory = FactoryBot.build(:inventory)
  end

  describe 'Inventoryの保存' do
    context "保存できる場合" do
      it "order,use,stockが数値でdateがある" do
        expect(@inventory).to be_valid
      end
      it "order,use,stockが空でdateがある" do
        @inventory.order = nil
        @inventory.use = nil
        @inventory.stock = nil
        expect(@inventory).to be_valid
      end
    end
    context "保存できない場合" do
      it "orderは数値以外は保存できない" do
        @inventory.order = "aaa"
        @inventory.valid?
        expect(@inventory.errors.full_messages).to include("Order is not a number")
      end
      it "useは数値以外は保存できない" do
        @inventory.use = "bbb"
        @inventory.valid?
        expect(@inventory.errors.full_messages).to include("Use is not a number")
      end
      it "stockは数値以外は保存できない" do
        @inventory.stock = "ccc"
        @inventory.valid?
        expect(@inventory.errors.full_messages).to include("Stock is not a number")
      end
      it "dateが空だと保存できない" do
        @inventory.date = nil
        @inventory.valid?
        expect(@inventory.errors.full_messages).to include("Date can't be blank")
      end
    end
  end
end
