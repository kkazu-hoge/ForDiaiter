class PjEvent < ApplicationRecord

  belongs_to :project
  # , foreign_key => "project_id"
  has_many :pj_event_details, dependent: :destroy
  # , foreign_key: "pj_event_id"
  has_many :trainings, through: :pj_event_details
  
end
