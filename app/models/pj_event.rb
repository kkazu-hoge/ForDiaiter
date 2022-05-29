class PjEvent < ApplicationRecord

  belongs_to :project
  has_many :pj_event_details, dependent: :destroy
  has_many :trainings, through: :pj_event_details

  validates :project_id, :action_day, :start_time,  presence: true

end
