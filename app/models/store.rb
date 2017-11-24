class Store < ApplicationRecord
  has_many :spaces, dependent: :destroy

  validates_presence_of :title, :city, :street

  def as_json(options = {})
    result = super({}).merge({ spaces_count: spaces.count })
  end
end
