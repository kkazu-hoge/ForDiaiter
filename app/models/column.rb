class Column < ApplicationRecord

  validates :title, :summary, presence: true

end
