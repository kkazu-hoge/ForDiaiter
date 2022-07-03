require 'rails_helper'

describe "会員モデルに関するテスト"  do

  #正常ケース
  context "性別：男性の全データが正常に設定されている場合" do
    it "データが正常に登録されること" do
      customer = FactoryBot.build(:customer)
      customer[:sex] = "man"
      expect(customer).to be_valid
    end
  end

  context "性別：女性の全データが正常に設定されている場合" do
    it "データが正常に登録されること" do
      customer = FactoryBot.build(:customer)
      customer[:sex] = "woman"
      expect(customer).to be_valid
    end
  end

  #異常ケース
  context "場合" do
    it "データが正常に登録されること" do
      customer = FactoryBot.build(:customer)
      customer[:last_name] = ""
      customer.valid?
      expect(customer.errors.full_messages).to include("名前を入力してください")
    end
  end
  
  context "性別：男性の全データが正常に設定されている場合" do
    it "データが正常に登録されること" do
      customer = FactoryBot.build(:customer)
      customer[:first_name] = ""
      expect(customer).to be_valid
    end
  end
  
  :public_name

end
