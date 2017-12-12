class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  enum rol: [:user, :admin]
  after_initialize :set_default_rol, if: :new_record?

  def admin?
    rol == 'admin'
  end

 private

  def set_default_rol
    self.rol ||= :user
  end

end
