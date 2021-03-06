class Refuel < ApplicationRecord
  belongs_to :user

  validates :date, :odometer, :volume, :user_id, presence: true
  validates :odometer, :volume, numericality: { greater_than: 0.0 }

  validate :price_and_cost, if: :volume
  validate :odometer_and_date

  def traveled
    previous = previous_full_refuel
    self.odometer - previous.odometer if previous
  end
  def filled_volume
    filled = self.volume
    previous = previous_refuel
    unless previous.nil? || previous.full
      filled += previous.filled_volume
    end
    return filled
  end

  def consumption
    trav = traveled 
    return (trav && full) ? (100 * filled_volume / trav) : nil
  end

 private

  # price or cost calculation
  def price_and_cost
    if price
      self.cost = price * volume
    elsif cost
      self.price = cost / volume
    end
  end

  # Check odometer and date consistency
  def odometer_and_date
    previous = previous_refuel
    errors.add :base, "Verifique la fecha" if previous && previous.date > date
    return errors.empty?
  end

  # Return previous refuel
  def previous_refuel
    Refuel.where(user_id: self.user_id).where("odometer < ?", self.odometer).order(:odometer).last
  end
  # Return previous full refuel
  def previous_full_refuel
    Refuel.where(user_id: self.user_id, full: true).where("odometer < ?", self.odometer).order(:odometer).last
  end
end

