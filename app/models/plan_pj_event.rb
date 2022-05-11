class PlanPjEvent < ApplicationRecord

  has_many :plan_pj_event_details, dependent: :destroy
  has_many :trainings,through: :plan_pj_event_details

end
