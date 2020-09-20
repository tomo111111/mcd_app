require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'Itemの保存' do
    context "保存できる場合" do
      it "name,marginがあり、marginが整数である" do
        expect(@item).to be_valid
      end
    end
    context "保存できない場合" do
      it "nameが空だと保存できない" do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "marginが空だと保存できない" do
        @item.margin = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Margin can't be blank")
      end
      it "marginが整数以外だと保存できない" do
        @item.margin = 2.2
        @item.valid?
        expect(@item.errors.full_messages).to include("Margin must be an integer")
      end
    end
  end
end
