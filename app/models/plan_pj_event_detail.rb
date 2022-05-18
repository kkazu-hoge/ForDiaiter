class PlanPjEventDetail < ApplicationRecord

  belongs_to :plan_pj_event
  # , foreign_key: "plan_pj_event_id"
  belongs_to :training
  # , foreign_key: "training_id"

end
