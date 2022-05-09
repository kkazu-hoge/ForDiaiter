class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  
  has_one_attached:image

  enum sex: { man: 1, woman: 2 }
  enum is_deleted: { available: false, unsubscribing: true }

end
