require 'rails_helper'

describe "会員モデルに関するテスト"  do

  #正常ケース
  context "性別：男性の全データが正常に設定されている場合" do
    it "データが正常に登録される" do
      customer = FactoryBot.build(:customer)
      customer[:sex] = "man"
      expect(customer).to be_valid
    end
  end

  context "性別：女性の全データが正常に設定されている場合" do
    it "データが正常に登録される" do
      customer = FactoryBot.build(:customer)
      customer[:sex] = "woman"
      expect(customer).to be_valid
    end
  end

  #

end
