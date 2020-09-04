require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'store_nameとstore_numberとemail、passwordとpassword_confirmationが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'store_nameが空では登録できないこと' do
      @user.store_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Store name can't be blank")
    end

    it 'store_nameが「〜店」と入力されていないと登録できないこと' do
      @user.store_name = 'みかんてん'
      @user.valid?
      expect(@user.errors.full_messages).to include('Store name 「◯◯店」と入力してください。')
    end

    it 'store_numberが空では登録できないこと' do
      @user.store_number = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Store number can't be blank")
    end

    it 'store_numberが6桁の数字でないと登録できないこと' do
      @user.store_number = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Store number 6桁の数字を入力してください。')
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
