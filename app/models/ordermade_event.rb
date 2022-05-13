class OrdermadeEvent < ApplicationRecord

  has_many:ordermade_event_details

  enum stress_level_param: { high: 1, middle: 10, low: 30 }
  enum activity_type_param: { aerobic_only: 60, anaerobic_only: 100, no_limit: 150  }
  enum place_param: { indoor_only: 28, outdoor_available: 36 }
  enum equipment_param: { no_equipment: 45, no_limit: 55 }

end
