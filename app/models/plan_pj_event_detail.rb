class PlanPjEventDetail < ApplicationRecord

  belongs_to :plan_pj_event
  belongs_to :training

  validates :plan_pj_event_id, :training_id, :activity_minutes, :burn_calories, presence: true

end
