class PlanPjEvent < ApplicationRecord

  belongs_to :project
  # , foreign_key => "project_id"
  has_many :plan_pj_event_details
  # , foreign_key: "plan_pj_event_id", dependent: :destroy
  has_many :trainings,through: :plan_pj_event_details

end
