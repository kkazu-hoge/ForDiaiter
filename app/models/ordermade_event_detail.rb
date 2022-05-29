class OrdermadeEventDetail < ApplicationRecord

  belongs_to:ordermade_event
  belongs_to:training

  validates :ordermade_event_id, :training_id, presence: true

end
