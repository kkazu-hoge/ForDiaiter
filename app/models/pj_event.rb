class PjEvent < ApplicationRecord

  belongs_to :project, foreign_key => "project_id"
  has_many :pj_event_details, dependent: :destroy
  has_many :trainings, through: :pj_event_details

end
