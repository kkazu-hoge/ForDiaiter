require 'rails_helper'

RSpec.describe Customer, type: :model do
    it "is valid with a name, email and password"
    it "is invalid without a name"
    it "is invalid without an email address"
    it "is invalid without a duplicate email address"
end
