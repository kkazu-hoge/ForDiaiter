# frozen_string_literal: true

require 'rails_helper'

describe "会員情報変更のテスト" do
  let!(:customer) { create(:customer, title:'hoge',body:'body') }
  before do
    @customer = FactoryBot.build(:customer)
  end


end