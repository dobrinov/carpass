class History < ApplicationRecord
  belongs_to :car
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

  validates :happened_at, presence: true
  validates :cost, numericality: { allow_blank: true, greater_than_or_equal_to: 0 }
  validate :valid_until_is_after_happened_at

  def notify_about_expiration?
    expiration_notification_class.present?
  end

  def expiration_notification_class
    nil
  end

  def notify_expiration
    # Do nothing
  end

  private

  def valid_until_is_after_happened_at
    if valid_until.present? && valid_until < happened_at
      errors.add(:valid_until, I18n.t('activerecord.errors.models.history.attributes.valid_until.in_the_past'))
    end
  end
end
