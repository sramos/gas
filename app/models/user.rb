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

  def total_odometer full=false
    total = 0.0
    last_ref = full ? refuels.where(full: true).order(:odometer).last : refuels.order(:odometer).last
    if last_ref && refuels.count > 1
      total = last_ref.odometer - refuels.order(:odometer).first.odometer
    end
    return total
  end

  def total_volume full=false
    first_ref = refuels.order(:odometer).first
    last_ref = full ? refuels.where(full: true).order(:odometer).last : refuels.order(:odometer).last
    return refuels.where("odometer > ? AND odometer <= ?", first_ref.odometer, last_ref.odometer).sum(:volume) if first_ref && last_ref
  end

 private

  def set_default_rol
    self.rol ||= :user
  end

end
