class PlanPjEvent < ApplicationRecord

  belongs_to :project
  has_many :plan_pj_event_details, dependent: :destroy
  has_many :trainings,through: :plan_pj_event_details

  validates :project_id, presence: true

end
