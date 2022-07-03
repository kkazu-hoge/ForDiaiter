require 'rails_helper'

describe "会員モデルに関するテスト"  do

  describe '正常系テスト' do

    context "性別男性(sex)が正常に設定されている場合" do
      it "データが正常に登録されること" do
        customer = FactoryBot.build(:customer)
        customer[:sex] = "man"
        expect(customer).to be_valid
      end
    end

    context "性別女性(sex)が正常に設定されている場合" do
      it "データが正常に登録されること" do
        customer = FactoryBot.build(:customer)
        customer[:sex] = "woman"
        expect(customer).to be_valid
      end
    end

  end



  describe '異常系テスト_入力値が空' do

    context "名前（姓）(last_name)が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:last_name] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("名前（姓） が入力されていません")
      end
    end

    context "名前（名）(first_name)が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:first_name] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("名前（名） が入力されていません")
      end
    end

    context "公開ネーム(public_name)が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:public_name] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("公開ネーム が入力されていません")
      end
    end

    context "メールアドレス(email)が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:email] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("メールアドレス が入力されていません")
      end
    end

    context "性別(sex)が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:sex] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("性別 が入力されていません")
      end
    end

    context "誕生日が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:birthday] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("誕生日 が入力されていません")
      end
    end

    context "身長が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:height] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("身長 が入力されていません")
      end
    end

    context "体重が入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer[:weight] = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("体重 が入力されていません")
      end
    end

    context "パスワードが入力されていない場合" do
      it "データが登録されずバリデーションのエラーメッセージが表示される" do
        customer = FactoryBot.build(:customer)
        customer.password = ""
        customer.valid?
        expect(customer.errors.full_messages).to include("パスワード が入力されていません")
      end
    end

    # context "が入力されていない場合" do
    #   it "データが登録されずバリデーションのエラーメッセージが表示される" do
    #     customer = FactoryBot.build(:customer)
    #     customer[:public_name] = ""
    #     customer.valid?
    #     expect(customer.errors.full_messages).to include("公開ネーム が入力されていません")
    #   end
    # end

  end

  # describe '異常系のテスト_境界値' do

  # end


end
