class Column < ApplicationRecord

  # 一旦保留
  # belongs_to:admin
  
  has_one_attached:image
  
end
