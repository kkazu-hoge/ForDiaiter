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
  context "名前（姓）が入力されていない場合" do
    it "データが登録されずバリデーションのエラーメッセージが表示される" do
      customer = FactoryBot.build(:customer)
      customer[:last_name] = ""
      customer.valid?
      expect(customer.errors.full_messages).to include("名前（姓） が入力されていません")
    end
  end

  context "名前（名）が入力されていない場合" do
    it "データが登録されずバリデーションのエラーメッセージが表示される" do
      customer = FactoryBot.build(:customer)
      customer[:first_name] = ""
      customer.valid?
      expect(customer.errors.full_messages).to include("名前（名） が入力されていません")
    end
  end

  context "公開ネームが入力されていない場合" do
    it "データが登録されずバリデーションのエラーメッセージが表示される" do
      customer = FactoryBot.build(:customer)
      customer[:public_name] = ""
      customer.valid?
      expect(customer.errors.full_messages).to include("公開ネーム が入力されていません")
    end
  end


end
