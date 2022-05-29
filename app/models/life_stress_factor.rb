class LifeStressFactor < ApplicationRecord

  has_many :projects

  validates :name, :coefficient, presence: true

end
