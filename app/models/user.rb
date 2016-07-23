class User < ActiveRecord::Base
  has_secure_password

  has_many :cars, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :setting

  # Validations
  validates :email,
            :presence   => true,
            :uniqueness => true,
            :format     => {
              :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
            }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  def send_password_reset_token
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.current
    save!
    UserMailer.password_reset(self).deliver_now
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def facebook_user?
    provider == 'facebook'
  end

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
