class Project < ApplicationRecord

  belongs_to :customer
  belongs_to :life_stress_factor
  has_many :pj_events, dependent: :destroy
  has_many :plan_pj_events, dependent: :destroy
  enum sex: { man: 1, woman: 2 }

end
