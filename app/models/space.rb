class Space < ApplicationRecord
  belongs_to :store

  validates_presence_of :title, :size, :price_per_day

  def price(start_date, end_date)
    total_days = end_date - start_date + 1

    total_price = BigDecimal.new("0.0")

    if price_per_month
      total_months = (total_days / 30).floor

      total_price += total_months * price_per_month
      
      total_days -= total_months * 30
    end

    if price_per_week
      total_week = (total_days / 7).floor

      total_price += total_week * price_per_week

      total_days -= total_week * 7
    end

    total_price += total_days * price_per_day

    total_price
  end
end
