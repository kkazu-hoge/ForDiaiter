class PjEventDetail < ApplicationRecord

  belongs_to :pj_event
  belongs_to :training

  validates :pj_event_id, :training_id, :activity_minutes, :burn_calories, presence: true

end
