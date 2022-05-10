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


  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "ゲスト(姓)"
      customer.first_name = "ゲスト(名)"
      customer.public_name = "ゲスト"
      customer.sex = "man"
      customer.birthday = "2000-07-07"
      customer.height = 170
      customer.weight = 70
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

end
