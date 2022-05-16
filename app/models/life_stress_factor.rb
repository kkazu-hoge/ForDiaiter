class LifeStressFactor < ApplicationRecord

  has_many :projects
  # has_many :projects, foreign_key => "life_stress_factor_id"

end
