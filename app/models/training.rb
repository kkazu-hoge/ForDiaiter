class Training < ApplicationRecord

  has_many :pj_event_details
  # , foreign_key: "training_id"
  has_many :plan_pj_event_details
# 　, foreign_key: "training_id"
  has_many :ordermade_event_details
# 　, foreign_key: "training_id"

end
