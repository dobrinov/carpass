class History < ActiveRecord::Base
  belongs_to :car
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

  validates :happened_at, presence: true

  validates :cost, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }

  def notify_about_expiration?
    expiration_notification_class.present?
  end

  def expiration_notification_class
    nil
  end

  def notify_expiration
    # Do nothing
  end
end
