class Training < ApplicationRecord

  has_many :pj_event_details
  has_many :plan_pj_event_details
  has_many :ordermade_event_details

  validates :name, :training_id, :mets_value, presence: true

end
