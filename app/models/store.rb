class Store < ApplicationRecord
  has_many :spaces, dependent: :destroy

  validates_presence_of :title, :city, :street
end
