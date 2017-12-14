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

  def total_odometer
    total = 0.0
    if refuels.count > 1
      total = refuels.order(:odometer).last.odometer - refuels.order(:odometer).first.odometer
    end
    return total
  end

  def total_volume
    return refuels.sum(:volume)
  end

 private

  def set_default_rol
    self.rol ||= :user
  end

end
