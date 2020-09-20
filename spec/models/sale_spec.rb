require 'rails_helper'

RSpec.describe Sale, type: :model do
  before do
    @sale = FactoryBot.build(:sale)
  end


  describe 'Saleの保存' do
    context "保存できる場合" do
      it "planが整数でactualが整数でdateがある" do
        expect(@sale).to be_valid
      end
      it "actualが空でも保存できる" do
        @sale.actual = nil
        expect(@sale).to be_valid
      end
    end
    context "保存できない場合" do
      it "planが空だと保存できない" do
        @sale.plan = nil
        @sale.valid?
        expect(@sale.errors.full_messages).to include("Plan can't be blank")
      end
      it "planが整数以外だと保存できない" do
        @sale.plan = 1.1
        @sale.valid?
        expect(@sale.errors.full_messages).to include("Plan must be an integer")
      end
      it "actualが整数以外だと保存できない" do
        @sale.actual = 9.9
        @sale.valid?
        expect(@sale.errors.full_messages).to include("Actual must be an integer")
      end
      it "dateが空だと保存できない" do
        @sale.date = nil
        @sale.valid?
        expect(@sale.errors.full_messages).to include("Date can't be blank")
      end
    end
  end
end
