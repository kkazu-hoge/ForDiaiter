class PjEventDetail < ApplicationRecord

  belongs_to :pj_event
  # , foreign_key: "pj_event_id"
  belongs_to :training
  # , foreign_key: "training_id"

end
