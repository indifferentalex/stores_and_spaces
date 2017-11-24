class Space < ApplicationRecord
  belongs_to :store

  validates_presence_of :title, :size, :price_per_day
end
