class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  has_many :refuels

  validates :name, :email, presence: true

  enum rol: [:user, :admin]
  after_initialize :set_default_rol, if: :new_record?

  def admin?
    rol == 'admin'
  end

  def average_consumption
    average = 0.0
    if refuels.count > 1
      total_odometer = refuels.order(:odometer).last.odometer - refuels.order(:odometer).first.odometer
      average = 100 * refuels.sum(:volume) / total_odometer
      puts "Total odometer: " + total_odometer.to_s
      puts "Total volume: " + Refuel.sum(:volume).to_s
    end
    return average
  end
 private

  def set_default_rol
    self.rol ||= :user
  end

end
