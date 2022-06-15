class Contact < ApplicationRecord
  validates :customer_id, presence: true
  validates :name, presence: true
  validates :content, presence: true
end
