class User < ActiveRecord::Base
  has_secure_password

  has_many :cars, dependent: :destroy

  # Validations
  validates :email,
            :presence   => true,
            :uniqueness => true,
            :format     => {
              :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
            }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  def histories
    History.where(car_id: cars.pluck(:id))
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def handle
    full_name.present? ? full_name : email
  end
end
