class Refuel < ApplicationRecord
  validates :date, :odometer, :volume, presence: true
  validates :odometer, :volume, numericality: { greater_than: 0.0 }

  validate :price_and_cost, if: :volume

 private

  def price_and_cost
    if price
      self.cost = price * volume
    elsif cost
      self.price = cost / volume
    end
  end
end
