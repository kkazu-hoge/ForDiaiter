class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy

  has_one_attached:image

  enum sex: { man: 1, woman: 2 }
  enum is_deleted: { no_delete: false, unsubscribed: true }

  validates :last_name, :first_name, :public_name,
            :sex, :birthday,:height,:weight,
            presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は英数字をそれぞれ含めてください" }, on: :create
  validates :height, numericality: {greater_than: 139,less_than: 201, message: "はプルダウンの設定値を選択してください"}
  validates :weight, numericality: {greater_than: 39,less_than: 131, message: "はプルダウンの設定値を選択してください"}

  ######インスタンスメソッド######


  ######クラスメソッド######
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password     = SecureRandom.hex(20)
      customer.last_name    = "ゲスト(姓)"
      customer.first_name   = "ゲスト(名)"
      customer.public_name  = "ゲスト"
      customer.sex          = "man"
      customer.birthday     = "2000-07-07"
      customer.height       = 170
      customer.weight       = 70
    end
  end


  def self.birthday_transfer_age(birthday)#birthday = date型
    result = (Date.current.strftime("%Y%m%d").to_i -  birthday.strftime("%Y%m%d").to_i) / 10000
    return result
  end



end
